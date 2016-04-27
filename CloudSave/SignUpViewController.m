//
//  SignUpViewController.m
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "SignUpViewController.h"
#import "AccountRequest.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *actionButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mailTextField becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) return NO;
    
    if (textField == self.mailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self onClickActionButton:self.actionButton];
    }
    return YES;
}

#pragma mark - Events

- (IBAction)onClickSegmentControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.actionButton setTitle:@"注册" forState:UIControlStateNormal];
    } else {
        [self.actionButton setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (IBAction)onClickActionButton:(UIButton *)sender {
    NSString *mailString = self.mailTextField.text;
    NSString *password  = self.passwordTextField.text;
    
    if (mailString.length == 0|| password.length == 0) {
        [self showErrorMessage:@"请填写邮箱和密码"];
        return;
    }
    [self showProgressView];
    __weak typeof(self) wSelf = self;
    if ([sender.titleLabel.text isEqualToString:@"注册"]) {
        [[AccountRequest request] signUpUserEmail:mailString
                                     withPassword:password
                                        onSuccess:^(NSDictionary *dict) {
                                            [wSelf loginSuccessed];
                                        } onFailure:^(NSInteger statusCode, NSString *msg) {
                                            [wSelf showErrorMessage:msg];
                                        } onFinish:^{
                                            [wSelf hideProgressView];
                                        }];
    } else {
        [[AccountRequest request] signInUserEmail:mailString //@"wushengwuxi01@163.com"
                                     withPassword:password   //@"ibest0"
                                        onSuccess:^(NSDictionary *dict) {
                                            [wSelf loginSuccessed];
                                        } onFailure:^(NSInteger statusCode, NSString *msg) {
                                            [wSelf showErrorMessage:msg];
                                        } onFinish:^{
                                            [wSelf hideProgressView];
                                        }];
    }
}

- (void)loginSuccessed {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CSLoginSuccessed" object:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
