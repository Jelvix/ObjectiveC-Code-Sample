//
//  UIImageView+Network.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "UIImageView+Remote.h"
#import "JXImageCache.h"
#import <objc/runtime.h>

static char TAG_CURRENT_TASK;

@implementation UIImageView (Remote)

- (void)setCurrentTask:(NSURLSessionTask *)currentTask {
    objc_setAssociatedObject(self, &TAG_CURRENT_TASK, currentTask, OBJC_ASSOCIATION_COPY);
}

- (NSURLSessionTask *)currentTask {
    return (NSURLSessionTask *)objc_getAssociatedObject(self, &TAG_CURRENT_TASK);
}

- (void)jx_setImageWith:(NSURL *)url {
    [self.currentTask cancel];
    self.currentTask = nil;
    self.image = nil;

    UIImage *cachedImage = [JXImageCache imageWith:url];
    if (cachedImage != nil) {
        self.image = cachedImage;
        return;
    }

    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakSelf.currentTask = nil;
        if (data == nil) {
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        if (image != nil) {
            [JXImageCache saveImage:image withUrl:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.image = image;
            });
        }
    }];
    self.currentTask = downloadTask;
    [downloadTask resume];
}

@end
