//
//  ComposeViewController.m
//  Instagram
//
//  Created by Surbhi Jain on 7/6/21.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UITextField *postCaptionField;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"image_placeholder"] forState:UIControlStateNormal];
    self.postCaptionField.text = @"";
    
  
}
- (IBAction)didTapPhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resizedImage = [self resizeImage:editedImage withSize:CGSizeMake(350, 350)];
    
    [self.imageButton setImage:nil forState:UIControlStateNormal];
    [self.imageButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.imageButton setImage:resizedImage forState:UIControlStateNormal];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (IBAction)didTapCancel:(id)sender {
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"image_placeholder"] forState:UIControlStateNormal];
    self.postCaptionField.text = @"";
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapShare:(id)sender {
    if (![self.imageButton.imageView.image isEqual:nil]) {
        [Post postUserImage:self.imageButton.imageView.image withCaption:self.postCaptionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"imaged posted");
            } else {
                NSLog(@"imaged not posted");
            }
        }];
        // dismiss compose view controller to go back to feed
        [self dismissViewControllerAnimated:true completion:nil];
    } else {
        NSLog(@"Please upload and photo");
    }
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
