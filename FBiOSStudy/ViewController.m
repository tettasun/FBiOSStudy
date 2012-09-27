//
//  ViewController.m
//  FBiOSStudy
//
//  Created by 村上 哲太郎 on 12/09/27.
//  Copyright (c) 2012年 村上 哲太郎. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSNotificationCenter * center;
    center = [NSNotificationCenter defaultCenter];
    // Observerとして登録する
    [center addObserver:self selector:@selector(fbSessionStateChanged:)
                   name:@"FBSessionSateChanged" object:nil];
}


-(void)fbSessionStateChanged:(NSNotification* )notification
{
    //値の引き出し
    int state =  [[notification.userInfo objectForKey:@"state"] intValue];
    
    switch (state) {
            
        case FBSessionStateOpen:
            NSLog(@"FBSessionStateOpen");
            [self populateUserDetails];
            break;
        case FBSessionStateClosed:
            NSLog(@"FBSessionStateClosed");
           self.nameLabel.text = @"";
            break;
        case FBSessionStateClosedLoginFailed:
            NSLog(@"FBSessionStateClosedLoginFailed");
            self.nameLabel.text = @"";
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;

    if (![app openSessionWithAllowLoginUI:NO]) {
        // No? Display the login page.
        [app showLoginView];
    }
}

- (IBAction)logout:(id)sender
{
    NSLog(@"Logout");
    [FBSession.activeSession closeAndClearTokenInformation];
   
    self.nameLabel.text = @"";
    self.pictureView.profileID = nil;
    //[self populateUserDetails];
    
    return;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    if (![app openSessionWithAllowLoginUI:NO]) {
        // No? Display the login page.
        [app showLoginView];
    }
}

- (IBAction)post:(id)sender
{
    NSLog(@"Post");
    
    UIImage *img = [UIImage imageNamed:@"img.jpg"];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:@"your custom message" forKey:@"message"];
    [params setObject:UIImagePNGRepresentation(img) forKey:@"picture"];
    _postButton.enabled = NO; //for not allowing multiple hits
    
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"error %@",[error localizedDescription]);
         }
         else
         {
             UIAlertView *alert =
             [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"完了しました"
                                       delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
             [alert show];
         }
         _postButton.enabled = YES;
     }];

}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.nameLabel.text = user.name;
                 self.pictureView.profileID = [user objectForKey:@"id"];
             }
         }];
    }
}

@end
