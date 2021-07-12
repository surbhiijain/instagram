//
//  PostCell.h
//  Instagram
//
//  Created by Surbhi Jain on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomUsernameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (nonatomic, strong) Post *post;

- (void)refreshData;

@end
