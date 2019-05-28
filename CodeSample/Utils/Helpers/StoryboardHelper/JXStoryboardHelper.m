//
//  JXStoryboardHelper.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXStoryboardHelper.h"

@implementation JXStoryboardHelper

+ (UIStoryboard *)authorizationStoryboard {
    return [UIStoryboard storyboardWithName:@"Authorization" bundle:nil];
}

+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
