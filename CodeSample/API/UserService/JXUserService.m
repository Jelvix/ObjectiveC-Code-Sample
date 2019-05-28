//
//  JXUserService.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXUserService.h"

@implementation JXUserService

+ (void)login:(JXLoginRequest *)loginRequestModel success:(successBlock)success failed:(failureBlock)failed {
    NSURLRequest *request = [ApiRequest logIn:loginRequestModel];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failed(error);
        } else {
            NSError *error;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSString *token = response[@"data"][@"api_token"];
            ApiRequest.token = token;
            success();
        }
    }] resume];
}

+ (void)matchUser:(NSString *)userId matchType:(MatchType)matchType failed:(failureBlock)failed {
    NSURLRequest *request = [ApiRequest matchUserWith:matchType userId:userId];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failed(error);
        }
    }] resume];
}

@end
