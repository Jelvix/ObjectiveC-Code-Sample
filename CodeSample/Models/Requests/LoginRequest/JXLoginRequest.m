//
//  JXLoginRequest.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXLoginRequest.h"

@interface JXLoginRequest()

@property (nonatomic, copy) NSString *facebookId;
@property (nonatomic, copy) NSString *facebookToken;

@end

@implementation JXLoginRequest

- (instancetype)initWithFacebookId:(NSString *)facebookId facebookToken:(NSString *)facebookToken {
    self = [super init];
    if (self) {
        self.facebookId = facebookId;
        self.facebookToken = facebookToken;
    }
    return self;
}

- (NSDictionary *)toJSON {
    return @{@"id": self.facebookId,
             @"token": self.facebookToken};
}

@end
