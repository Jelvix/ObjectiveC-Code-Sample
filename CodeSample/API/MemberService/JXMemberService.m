//
//  JXMemberService.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXMemberService.h"

@implementation JXMemberService

+ (void)recommendedUsers:(successUsersBlock)success failed:(failureBlock)failed {
    NSURLRequest *request = [ApiRequest getRecommendedUsers];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failed(error);
        } else {
            NSError *error;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSArray *results = response[@"data"][@"results"];
            if ([results isKindOfClass:[NSArray class]]) {
                NSMutableArray *users = [NSMutableArray new];
                for (NSDictionary *result in results) {
                    JXUserModel *model = [[JXUserModel alloc] initWithJSON:result[@"user"]];
                    [users addObject:model];
                }
                success(users);
            } else {
                success(@[]);
            }
        }
    }] resume];
}
@end
