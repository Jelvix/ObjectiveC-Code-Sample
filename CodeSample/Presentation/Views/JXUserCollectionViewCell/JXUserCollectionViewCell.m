//
//  JXUserCollectionViewCell.m
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import "JXUserCollectionViewCell.h"

@implementation JXUserCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupShadow];
    [self hideIcons];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.userAvatar.image = nil;
    [self hideIcons];
}

- (void)hideIcons {
    self.dislikeIcon.alpha = 0;
    self.likeIcon.alpha = 0;
}

- (void)setupShadow {
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

@end
