//
//  ComposeViewController.h
//  Instagram
//
//  Created by Surbhi Jain on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didPost;

@end

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
