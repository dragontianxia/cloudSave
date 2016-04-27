//
//  CSParentViewController.m
//  CloudSave
//
//  Created by Ron on 16/1/31.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "CSParentViewController.h"
#import "SignUpViewController.h"

@interface CSParentViewController ()

@end

@implementation CSParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessed)
                                                 name:@"CSLoginSuccessed"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loginSuccessed {
//    [self performSegueWithIdentifier:@"gotoFavorListView" sender:nil];
}

- (void)showLoginView {
    SignUpViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController presentViewController:loginVC animated:YES completion:^{
        
    }];
}

@end
