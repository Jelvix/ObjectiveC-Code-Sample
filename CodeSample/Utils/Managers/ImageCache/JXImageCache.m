//
//  JXImageCache.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXImageCache.h"

@implementation JXImageCache

+ (NSURL *)cachePathFor:(nonnull NSURL *)url {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [NSString stringWithFormat:@"%@%@", cachePath, url.lastPathComponent];
    return [NSURL fileURLWithPath:path];
}

+ (UIImage *)imageWith:(NSURL *)url {
    NSURL *cachePath = [self cachePathFor:url];
    if (cachePath == nil) {
        return nil;
    }
    return [UIImage imageWithContentsOfFile:cachePath.path];
}

+ (void)saveImage:(UIImage *)image withUrl:(NSURL *)url {
    NSURL *cachePath = [self cachePathFor:url];
    if (cachePath == nil) {
        return;
    }
    [UIImageJPEGRepresentation(image, 1.0) writeToURL:cachePath atomically:YES];
}

@end
