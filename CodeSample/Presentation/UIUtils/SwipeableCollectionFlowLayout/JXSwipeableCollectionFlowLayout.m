//
//  JXSwipeableCollectionFlowLayout.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXSwipeableCollectionFlowLayout.h"

static CGFloat minXToSwipe = 100;
static CGFloat defaultRotationAngle = (M_PI) / 10.0;
static NSUInteger maxCardsCount = 2;

@interface JXSwipeableCollectionFlowLayout()

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) NSIndexPath *draggedCellAtIndexPath;
@property (assign, nonatomic) CGPoint initialCellCenter;

@end

@implementation JXSwipeableCollectionFlowLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        self.draggedCellAtIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return self;
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *indexPathes = [NSMutableArray new];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathes addObject:indexPath];
    }
    
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    for (NSIndexPath * indexPath in indexPathes) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (attributes) {
            [layoutAttributes addObject:attributes];
        }
    }
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.hidden = (attributes.indexPath.item >= maxCardsCount); //Hide cards for best perfomance
    attributes.frame = self.collectionView.bounds;
    if (indexPath.item == 0) {
        attributes.zIndex = 100000;
    } else {
        attributes.zIndex = (1000 - indexPath.item);
    }
    return attributes;
}

-(void)setGesturesEnabled:(BOOL)gesturesEnabled {
    if (gesturesEnabled) {
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.maximumNumberOfTouches = 1;
        [self.collectionView addGestureRecognizer:recognizer];
        self.panGestureRecognizer = recognizer;
    } else {
        if (self.panGestureRecognizer) {
            [self.collectionView removeGestureRecognizer:self.panGestureRecognizer];
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    CGPoint newCenter = [sender translationInView:self.collectionView];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self bringTopCardToFront];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateTopCardPosition:newCenter];
            break;
        default:
            [self didFinishDragging];
            break;
    }
}

- (void)bringTopCardToFront {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.draggedCellAtIndexPath];
    if (cell != nil) {
        self.initialCellCenter = cell.center;
        [self.collectionView bringSubviewToFront:cell];
    }
}

- (void)updateTopCardPosition:(CGPoint)touchCoordinate {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.draggedCellAtIndexPath];
    if (cell != nil) {
        CGFloat rotationStrength = MIN(touchCoordinate.x / self.collectionView.frame.size.width, 1.0);
        CGFloat rotationAngle = defaultRotationAngle * rotationStrength;
        CGFloat scaleStrength = 1 - ((1 - 0.8) * fabs(rotationStrength));
        CGFloat scale = MAX(scaleStrength, 0.8);
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformScale(transform, scale, 1);
        transform = CGAffineTransformRotate(transform, rotationAngle);
        
        CGFloat newCenterX = (self.initialCellCenter.x + touchCoordinate.x);
        CGFloat newCenterY = (self.initialCellCenter.y + touchCoordinate.y);
        cell.center = CGPointMake(newCenterX, newCenterY);
        cell.transform = transform;
        
        CGFloat swipeProgress = fabs(cell.center.x - self.initialCellCenter.x) / minXToSwipe;
        JXSwipeDirection swipeDirection = (self.initialCellCenter.x > cell.center.x) ? JXSwipeDirectionLeft : JXSwipeDirectionRight;
        if ([self.delegate respondsToSelector:@selector(cardDidChangeSwipeProgress:swipeDirection:)]) {
            [self.delegate cardDidChangeSwipeProgress:swipeProgress swipeDirection:swipeDirection];
        }
    }
}

- (void)didFinishDragging {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.draggedCellAtIndexPath];
    if (cell != nil) {
        CGFloat deltaX = fabs(cell.center.x - self.initialCellCenter.x);
        CGFloat shouldSnapBack = (deltaX < minXToSwipe);
        if (shouldSnapBack) {
            [UIView animateWithDuration:0.3 animations:^{
                cell.center = self.initialCellCenter;
                cell.transform = CGAffineTransformIdentity;
            }];
            if ([self.delegate respondsToSelector:@selector(cardSwipeDidCancel)]) {
                [self.delegate cardSwipeDidCancel];
            }
        }
        else {
            self.collectionView.userInteractionEnabled = NO;
            JXSwipeDirection swipeDirection = (self.initialCellCenter.x > cell.center.x) ? JXSwipeDirectionLeft : JXSwipeDirectionRight;
            [UIView animateWithDuration:0.3 animations:^{
                CGPoint newPoint = cell.center;
                cell.center = CGPointMake(swipeDirection, newPoint.y);
            } completion:^(BOOL finished) {
                self.collectionView.userInteractionEnabled = YES;
                [UIView setAnimationsEnabled:NO];
                if ([self.delegate respondsToSelector:@selector(cardDidFinishSwiping:)]) {
                    [self.delegate cardDidFinishSwiping:swipeDirection];
                }
                [UIView setAnimationsEnabled:YES];
            }];
        }
    }
}

@end
