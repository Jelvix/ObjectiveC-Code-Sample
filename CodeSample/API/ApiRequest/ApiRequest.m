//
//  ApiRequest.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "ApiRequest.h"

#define baseUrl [NSURL URLWithString:@"https://api.gotinder.com/"]

typedef enum HttpMethod {
    HttpMethodPost,
    HttpMethodGet
} HttpMethod;

#define HttpMethodValue(rawValue) methods[rawValue]
#define methods @[@"POST", @"GET"]

@implementation ApiRequest
static NSString* _token = nil;

+ (NSURLRequest *)logIn:(id <JXRequestProtocol>)model {
    NSString *path = @"v2/auth/login/facebook";
    return [self makeRequestWithMethod:HttpMethodPost path:path parameters:model.toJSON];
}

+ (NSURLRequest *)matchUserWith:(MatchType)matchType userId:(NSString *)userId {
    NSString *path = [NSString stringWithFormat:@"%@/%@", MatchTypeValue(matchType), userId];
    return [self makeRequestWithMethod:HttpMethodPost path:path parameters:nil];
}

+ (NSURLRequest *)getRecommendedUsers {
    NSString *path = @"v2/recs/core";
    return [self makeRequestWithMethod:HttpMethodGet path:path parameters:nil];
}

#pragma mark - Private

+ (NSString *)token {
    return _token;
}

+ (void)setToken:(NSString *)token {
    if (token != _token) {
        _token = [token copy];
    }
}

+ (NSURLRequest *)makeRequestWithMethod:(HttpMethod)httpMethod path:(NSString *)path parameters:(nullable NSDictionary *)parameters {
    NSURL *url = [baseUrl URLByAppendingPathComponent:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = HttpMethodValue(httpMethod);
    if (parameters != nil) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
        request.HTTPBody = postData;
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    if (self.token != nil) {
        [request setValue:self.token forHTTPHeaderField:@"x-auth-token"];
    }
    return request;
}

@end
