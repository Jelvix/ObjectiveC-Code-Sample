//
//  JXSwipeableCollectionFlowLayout.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JXSwipeDirection) {
    JXSwipeDirectionLeft = -2000,
    JXSwipeDirectionRight = 2000
};

@protocol JXSwipeableCollectionDelegate <NSObject>

- (void)cardDidFinishSwiping:(JXSwipeDirection)direction;
- (void)cardSwipeDidCancel;
- (void)cardDidChangeSwipeProgress:(CGFloat)progress swipeDirection:(JXSwipeDirection)direction;

@end

@interface JXSwipeableCollectionFlowLayout : UICollectionViewLayout

@property (weak, nonatomic) id <JXSwipeableCollectionDelegate> delegate;
@property (assign, nonatomic) BOOL gesturesEnabled;

@end
