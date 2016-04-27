//
//  FavorListViewController.m
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "FavorListViewController.h"
#import "FavorListTableViewCell.h"
#import "FavorRequest.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "FavorDetailViewController.h"

@interface FavorListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *allListTableView;
@property (weak, nonatomic) IBOutlet UITableView *articleListTableView;

@property (strong, nonatomic) NSMutableArray *allDataArray, *articleDataArray;
@property (assign, nonatomic) NSInteger       allDataPage, articleDataPage;
@property (assign, nonatomic) NSInteger       selectIndex;

@end

@implementation FavorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allDataArray     = [[NSMutableArray alloc] initWithCapacity:0];
    self.articleDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.allListTableView     setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.articleListTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.allDataPage     = 1;
    self.articleDataPage = 1;
    
    [self requestAllFavorList];
    
    __weak typeof(self) wSelf = self;
    [self.allListTableView addPullToRefreshWithActionHandler:^{
        wSelf.allDataPage = 1;
        [wSelf requestAllFavorList];
    }];
    
    [self.allListTableView addInfiniteScrollingWithActionHandler:^{
        [wSelf requestAllFavorList];
    }];

    [self.articleListTableView addPullToRefreshWithActionHandler:^{
        wSelf.articleDataPage = 1;
        [wSelf requestArticleFavorList];
    }];
    
    [self.articleListTableView addInfiniteScrollingWithActionHandler:^{
        [wSelf requestArticleFavorList];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)dealloc {
    NSLog(@"[TEST] FavorListViewController dealloc");
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FavorDetailViewController *detailVC = [segue destinationViewController];
    detailVC.urlString = sender;
}

- (IBAction)onClickSegmentControl:(UISegmentedControl *)sender {
    self.selectIndex = sender.selectedSegmentIndex;
    if (self.selectIndex > 0) {
        if (self.articleDataArray.count == 0) {
            [self requestArticleFavorList];
        }
    } else {
        if (self.allDataArray.count == 0) {
            [self requestAllFavorList];
        }
    }
    CATransition *animation = [CATransition animation];
    animation.type =@"rippleEffect";
    [animation setDuration:0.5];
    [animation setRepeatCount:1.0];
    [self.view.layer addAnimation:animation forKey:@"a rippleEffect"];
    [self.view bringSubviewToFront:self.selectIndex > 0 ? self.articleListTableView : self.allListTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.articleListTableView) {
        return self.articleDataArray.count;
    }
    return self.allDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavorListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FavorListTableViewCell description] forIndexPath:indexPath];
    if (tableView == self.articleListTableView) {
        [cell.titleLabel   setText:self.articleDataArray[indexPath.row][@"title"]];
        [cell.contentLabel setText:self.articleDataArray[indexPath.row][@"domainName"]];
    } else {
        [cell.titleLabel   setText:self.allDataArray[indexPath.row][@"title"]];
        [cell.contentLabel setText:self.allDataArray[indexPath.row][@"domainName"]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *urlString = @"http://www.wenba100.com";
    if (tableView == self.articleListTableView) {
        urlString = self.articleDataArray[indexPath.row][@"url"];
    } else {
        urlString = self.allDataArray[indexPath.row][@"url"];
    }
    [self performSegueWithIdentifier:@"gotoDeatailView" sender:urlString];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView == self.articleListTableView) {
            NSString *favorID = self.articleDataArray[indexPath.row][@"favId"];
            [self unfavor:favorID];
            [self.articleDataArray removeObjectAtIndex:indexPath.row];
        } else {
            NSString *favorID = self.allDataArray[indexPath.row][@"favId"];
            [self unfavor:favorID];
            [self.allDataArray removeObjectAtIndex:indexPath.row];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [tableView setEditing:NO animated:YES];
}

#pragma mark - Request

- (void)requestAllFavorList {
    [self showProgressView];
    __weak typeof(self) wSelf = self;
    [[FavorRequest request] favorListType:FavorListTypeAll
                                 withPage:self.allDataPage
                                onSuccess:^(NSArray *array) {
                                    if (wSelf.allDataPage == 1) {
                                        [wSelf.allDataArray removeAllObjects];
                                    }
                                    [wSelf.allListTableView setShowsInfiniteScrolling:(array.count == kFavorListPageLimit)];
                                    wSelf.allDataPage += 1;
                                    [wSelf.allDataArray addObjectsFromArray:array];
                                    [wSelf.allListTableView reloadData];
                                } onFailure:^(NSInteger statusCode, NSString *msg) {
                                    if (statusCode == 2) {
                                        [wSelf showLoginView];
                                    } else {
                                        [wSelf showErrorMessage:msg];
                                    }
                                } onFinish:^{
                                    [wSelf.allListTableView.pullToRefreshView stopAnimating];
                                    [wSelf.allListTableView.infiniteScrollingView stopAnimating];
                                    [wSelf hideProgressView];
                                }];
}

- (void)requestArticleFavorList {
    [self showProgressView];
    __weak typeof(self) wSelf = self;
    [[FavorRequest request] favorListType:FavorListTypeArticle
                                 withPage:self.articleDataPage
                                onSuccess:^(NSArray *array) {
                                    if (wSelf.articleDataPage == 1) {
                                        [wSelf.articleDataArray removeAllObjects];
                                    }
                                    [wSelf.articleListTableView setShowsInfiniteScrolling:(array.count == kFavorListPageLimit)];
                                    wSelf.articleDataPage += 1;
                                    [wSelf.articleDataArray addObjectsFromArray:array];
                                    [wSelf.articleListTableView reloadData];
                                } onFailure:^(NSInteger statusCode, NSString *msg) {
                                    [wSelf showErrorMessage:msg];
                                } onFinish:^{
                                    [wSelf.articleListTableView.pullToRefreshView stopAnimating];
                                    [wSelf.articleListTableView.infiniteScrollingView stopAnimating];
                                    [wSelf hideProgressView];
                                }];
}

- (void)unfavor:(NSString *)favorID {
    [[FavorRequest request] unfavorID:favorID
                            onSuccess:^(NSDictionary *dict) {
                                
                            } onFailure:^(NSInteger statusCode, NSString *msg) {
                                
                            } onFinish:^{
                                
                            }];
}

#pragma mark - ParentEvent

- (void)loginSuccessed {
    [self requestAllFavorList];
}

@end
