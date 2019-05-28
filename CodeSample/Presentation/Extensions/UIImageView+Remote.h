//
//  UIImageView+Network.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Remote)

@property (nonatomic, nullable) NSURLSessionTask *currentTask;

- (void)jx_setImageWith:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
