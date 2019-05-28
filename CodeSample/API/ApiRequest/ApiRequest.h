//
//  ApiRequest.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchType.h"

typedef void(^failureBlock)(NSError * _Nullable error);

@protocol JXRequestProtocol <NSObject>

- (NSDictionary *_Nonnull)toJSON;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ApiRequest : NSObject

@property (class, nonatomic, copy, nullable) NSString *token;

+ (NSURLRequest *)logIn:(id <JXRequestProtocol>)model;
+ (NSURLRequest *)matchUserWith:(MatchType)matchType userId:(NSString *)userId;
+ (NSURLRequest *)getRecommendedUsers;

@end

NS_ASSUME_NONNULL_END
