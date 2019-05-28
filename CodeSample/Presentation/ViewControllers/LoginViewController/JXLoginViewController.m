//
//  JXLoginViewController.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "JXLoginViewController.h"
#import "JXHomeViewController.h"
#import "JXStoryboardHelper.h"
#import "JXAlertHelper.h"
#import "JXLoginRequest.h"
#import "JXUserService.h"

@interface JXLoginViewController ()

@end

@implementation JXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)didTapLoginButton:(UIButton *)sender {
    [self authWithFacebook];
}

#pragma mark - Navigation

- (void)showHomeViewController {
    JXHomeViewController *vc = [JXStoryboardHelper.mainStoryboard instantiateViewControllerWithIdentifier:@"JXHomeNavigationViewController"];
    [self presentViewController:vc animated:true completion:nil];
}

#pragma mark - API part

- (void)authWithFacebook {
    FBSDKLoginManager *fbLogingManager = [[FBSDKLoginManager alloc] init];
    fbLogingManager.loginBehavior = FBSDKLoginBehaviorBrowser;

    __weak typeof(self) weakSelf = self;
    [fbLogingManager logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error == nil) {
            if ([result.grantedPermissions containsObject:@"email"]) {
                JXLoginRequest *loginModel = [[JXLoginRequest alloc] initWithFacebookId:result.token.userID
                                                                          facebookToken:result.token.tokenString];
                [weakSelf loginWithRequestModel:loginModel];
            }
        } else {
            [JXAlertHelper showAlertFor:error fromController:weakSelf];
        }
    }];
}

- (void)loginWithRequestModel:(JXLoginRequest *)requestModel {
    __weak typeof(self) weakSelf = self;
    [JXUserService login:requestModel success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showHomeViewController];
        });
    } failed:^(NSError * _Nonnull error) {
        [JXAlertHelper showAlertFor:error fromController:weakSelf];
    }];
}

@end
