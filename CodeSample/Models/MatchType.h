//
//  MatchType.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum MatchType {
    MatchTypePass,
    MatchTypeLike
} MatchType;

#define MatchTypeValue(rawValue) cases[rawValue]
#define cases @[@"pass", @"like"]

NS_ASSUME_NONNULL_END
