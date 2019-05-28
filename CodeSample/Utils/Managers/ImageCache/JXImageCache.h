//
//  JXImageCache.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXImageCache : NSObject

+ (UIImage *)imageWith:(NSURL *)url;
+ (void)saveImage:(UIImage *)image withUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
