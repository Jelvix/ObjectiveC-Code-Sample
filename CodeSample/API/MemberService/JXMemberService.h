//
//  JXMemberService.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXUserModel.h"
#import "ApiRequest.h"

typedef void(^successUsersBlock)(NSArray<JXUserModel *> * _Nullable users);

NS_ASSUME_NONNULL_BEGIN

@interface JXMemberService : NSObject

+ (void)recommendedUsers:(successUsersBlock)success failed:(failureBlock)failed;

@end

NS_ASSUME_NONNULL_END
