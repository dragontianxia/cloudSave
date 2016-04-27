//
//  RootViewController.m
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UIApplication sharedApplication] setStatusBarStyle:1];
    
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loginSuccessed)
//                                                 name:@"CSLoginSuccessed"
//                                               object:nil];
//    
    [self performSegueWithIdentifier:@"gotoFavorListView" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"[TEST] RootViewController dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)loginSuccessed {
//    [self performSegueWithIdentifier:@"gotoFavorListView" sender:nil];
//}

@end
