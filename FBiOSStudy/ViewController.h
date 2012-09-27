//
//  ViewController.h
//  FBiOSStudy
//
//  Created by 村上 哲太郎 on 12/09/27.
//  Copyright (c) 2012年 村上 哲太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController
- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)post:(id)sender;


@property IBOutlet UIButton *postButton;
@property IBOutlet UILabel *nameLabel;
@property IBOutlet FBProfilePictureView *pictureView;

- (void)initFacebook;

@end
