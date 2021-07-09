//
//  DetailsViewController.m
//  Instagram
//
//  Created by Surbhi Jain on 7/8/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"


@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomUsernameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (void)refreshData {
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
    
    PFUser *user = self.post.author;
    self.topUsernameLabel.text = user.username;
    self.bottomUsernameLabel.text = user.username;

    // use DateTools pod to add time ago feature
    NSDate *timeNow = [NSDate date];
    NSInteger seconds = [timeNow secondsFrom:self.post.createdAt];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    self.timestampLabel.text = timeDate.shortTimeAgoSinceNow;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
