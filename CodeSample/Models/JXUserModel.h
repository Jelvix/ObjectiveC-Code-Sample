//
//  JXUserModel.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXUserModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *avatarUrl;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
