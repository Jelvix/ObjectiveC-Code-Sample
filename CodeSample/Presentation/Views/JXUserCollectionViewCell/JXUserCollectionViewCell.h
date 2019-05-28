//
//  JXUserCollectionViewCell.h
//  CodeSample
//
//  Copyright © 2019 Jelvix. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const JXReuseIdentifierUserCell = @"JXReuseIdentifierUserCell";

@interface JXUserCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *likeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *dislikeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userbio;

@end
