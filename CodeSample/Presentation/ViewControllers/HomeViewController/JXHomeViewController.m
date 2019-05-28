//
//  JXHomeViewController.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXHomeViewController.h"
#import "JXUserModel.h"
#import "JXUserCollectionViewCell.h"
#import "JXUserService.h"
#import "JXMemberService.h"
#import "JXSwipeableCollectionFlowLayout.h"
#import "UIImageView+Remote.h"
#import "JXAlertHelper.h"

@interface JXHomeViewController () <UICollectionViewDataSource, JXSwipeableCollectionDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray<JXUserModel *> *users;
@property (strong, nonatomic) NSIndexPath *topIndexPath;

@end

@implementation JXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.users = [NSMutableArray new];
    self.topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    [self configureNavigationBar];
    [self configurateCollectionView];
    [self loadRecommendedUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Configuration part

- (void)configureNavigationBar {
    UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tinder_match.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake( 0,  0,  self.view.frame.size.width,  44);
    self.navigationItem.titleView = imageView;
}

- (void)configurateCollectionView {
    [(JXSwipeableCollectionFlowLayout *)self.collectionView.collectionViewLayout setDelegate:self];
    [(JXSwipeableCollectionFlowLayout *)self.collectionView.collectionViewLayout setGesturesEnabled:YES];
}

#pragma mark - Logic

- (void)appendUsers:(NSArray<JXUserModel *> *)loadedUsers {
    NSUInteger startIndex = self.users.count;
    NSMutableArray *indexes = [NSMutableArray new];

    [self.users addObjectsFromArray:loadedUsers];

    for (NSUInteger index = startIndex; index < self.users.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [indexes addObject:indexPath];
    }

    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:indexes];
    } completion:nil];
}

- (void)removeFirstUser {
    [self.collectionView performBatchUpdates:^{
        [self.users removeObjectAtIndex:0];
        [self.collectionView deleteItemsAtIndexPaths:@[self.topIndexPath]];
    } completion:nil];

    if (self.users.count == 2) {
        [self loadRecommendedUsers];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.users.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JXUserCollectionViewCell *cell = (JXUserCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:JXReuseIdentifierUserCell forIndexPath:indexPath];
    [self configurate:cell atIndexPath:indexPath];
    return cell;
}

- (void)configurate:(JXUserCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    JXUserModel *user = self.users[indexPath.row];
    cell.userName.text = user.name;
    cell.userbio.text = user.bio;
    [cell.userAvatar jx_setImageWith:[NSURL URLWithString:user.avatarUrl]];
}

#pragma mark - JXSwipeableCollectionDelegate

- (void)cardDidFinishSwiping:(JXSwipeDirection)direction {
    switch (direction) {
        case JXSwipeDirectionLeft:
            [self matchUser:MatchTypePass user:[self.users.firstObject userID]];
            break;
        case JXSwipeDirectionRight:
            [self matchUser:MatchTypeLike user:[self.users.firstObject userID]];
            break;
    }
    [self removeFirstUser];
}

- (void)cardSwipeDidCancel {
    JXUserCollectionViewCell *cell = (JXUserCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:self.topIndexPath];
    cell.dislikeIcon.alpha = 0;
    cell.likeIcon.alpha = 0;
}

- (void)cardDidChangeSwipeProgress:(CGFloat)progress swipeDirection:(JXSwipeDirection)direction {
    JXUserCollectionViewCell *cell = (JXUserCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:self.topIndexPath];
    cell.dislikeIcon.alpha = (direction == JXSwipeDirectionLeft) ? progress : 0;
    cell.likeIcon.alpha = (direction == JXSwipeDirectionLeft) ? 0 : progress;
}

#pragma mark - API part

- (void)loadRecommendedUsers {
    __weak typeof(self) weakSelf = self;
    [JXMemberService recommendedUsers:^(NSArray<JXUserModel *> * _Nullable users) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf appendUsers:users];
        });
    } failed:^(NSError *error) {
        [JXAlertHelper showAlertFor:error fromController:weakSelf];
    }];
}

- (void)matchUser:(MatchType)type user:(NSString *)userID {
    __weak typeof(self) weakSelf = self;
    [JXUserService matchUser:userID matchType:type failed:^(NSError *error) {
        [JXAlertHelper showAlertFor:error fromController:weakSelf];
    }];
}

@end
