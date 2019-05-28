//
//  JXUserService.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXLoginRequest.h"
#import "ApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^successBlock)(void);

@interface JXUserService : NSObject

+ (void)login:(JXLoginRequest *)loginRequestModel success:(successBlock)success failed:(failureBlock)failed;
+ (void)matchUser:(NSString *)userId matchType:(MatchType)matchType failed:(failureBlock)failed;

@end

NS_ASSUME_NONNULL_END
