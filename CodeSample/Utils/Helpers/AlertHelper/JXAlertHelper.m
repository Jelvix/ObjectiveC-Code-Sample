//
//  JXAlertHelper.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXAlertHelper.h"

@implementation JXAlertHelper

+ (void)showAlertFor:(NSError *)error fromController:(nullable UIViewController *)controller {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [controller presentViewController:alert animated:YES completion:nil];
    });
}

@end
