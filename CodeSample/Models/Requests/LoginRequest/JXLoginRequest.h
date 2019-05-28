//
//  JXLoginRequest.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXLoginRequest : NSObject <JXRequestProtocol>

- (instancetype)initWithFacebookId:(NSString *)facebookId facebookToken:(NSString *)facebookToken;
- (NSDictionary *)toJSON;

@end

NS_ASSUME_NONNULL_END
