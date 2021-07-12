//
//  Post.m
//  Instagram
//
//  Created by Surbhi Jain on 7/6/21.
//


#import "Post.h"
#import "Parse/Parse.h"

@implementation Post
    
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic likesArray;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    newPost.likesArray = [NSMutableArray new];
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
     if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

- (void)likePost {
    NSString *userID = [PFUser currentUser].username;
    NSNumber *likeCountChange = @0;
    if ([self.likesArray containsObject:userID]) {
        [self.likesArray removeObject:userID];
        likeCountChange = @-1;
    } else {
        [self.likesArray addObject:userID];
        likeCountChange = @1;
    }
    self.likeCount = @([self.likeCount intValue] + [likeCountChange intValue]);
    [self saveInBackgroundWithBlock:nil];
}

@end

