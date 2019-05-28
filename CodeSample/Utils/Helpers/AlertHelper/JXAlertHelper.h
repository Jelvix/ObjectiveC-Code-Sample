//
//  JXAlertHelper.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXAlertHelper : NSObject

+ (void)showAlertFor:(NSError *)error fromController:(nullable UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
