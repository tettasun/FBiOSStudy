//
//  AppDelegate.h
//  FBiOSStudy
//
//  Created by 村上 哲太郎 on 12/09/27.
//  Copyright (c) 2012年 村上 哲太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)showLoginView;
@end
