//
//  JXUserModel.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXUserModel.h"

@implementation JXUserModel

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.name = json[@"name"];
        self.userID = json[@"_id"];
        self.bio = json[@"bio"];
        NSArray *photos = json[@"photos"];
        self.avatarUrl = photos.firstObject[@"url"];
    }
    return self;
}

@end
