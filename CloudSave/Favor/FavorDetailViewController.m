//
//  FavorDetailViewController.m
//  CloudSave
//
//  Created by Ron on 16/1/24.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "FavorDetailViewController.h"

@interface FavorDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation FavorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0f/255.0f green:147.0f/255.0f blue:204.0f/255.0f alpha:1]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
    
    // Do any additional setup after loading the view.
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"[TEST] FavorDetailViewController dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [self showErrorMessage:@"加载失败"];
}

@end
