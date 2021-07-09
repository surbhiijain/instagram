//
//  PostCell.m
//  Instagram
//
//  Created by Surbhi Jain on 7/6/21.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)refreshData {

    PFUser *user = self.post.author;
    self.topUsernameLabel.text = user.username;
    self.bottomUsernameLabel.text = user.username;
  
    // set the post UIImageView based on the PFImage pased in through parse
    [self.postImage setImage:nil];
    [self.post.image getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        UIImage *image = [UIImage imageWithData:imageData];
        [self.postImage setImage:image] ;
    }];
    
    self.captionLabel.text = self.post.caption;
    
    NSString *likesString = @" likes";
    if ([self.post.likeCount isEqualToNumber:@1]) {
        likesString = @" like";
    }
    self.likeCountLabel.text = [[self.post.likeCount stringValue] stringByAppendingString:likesString];

}

@end
