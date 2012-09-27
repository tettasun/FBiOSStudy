//
//  AppDelegate.m
//  FBiOSStudy
//
//  Created by 村上 哲太郎 on 12/09/27.
//  Copyright (c) 2012年 村上 哲太郎. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#define FB_APP_ID @"478845855483468"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FBProfilePictureView class];
    return YES;
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    return [FBSession openActiveSessionWithReadPermissions:nil
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                             [self sessionStateChanged:session state:state error:error];
                                         }];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState)state
                      error:(NSError *)error
{

    
    switch (state) {
            
        case FBSessionStateOpen:
            NSLog(@"FBSessionStateOpen");
            break;
        case FBSessionStateClosed:
            NSLog(@"FBSessionStateClosed");
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        case FBSessionStateClosedLoginFailed:
            NSLog(@"FBSessionStateClosedLoginFailed");
            
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    //登録
    NSDictionary *dic = @{@"state" : [NSNumber numberWithInt:state]};
    
    // NSNotificationを作成する
    NSNotification* notification;
    notification = [NSNotification notificationWithName:@"FBSessionSateChanged"
                                                 object:self userInfo:dic];
    
    // NSNotificationCenterを取得する
    NSNotificationCenter* center;
    center = [NSNotificationCenter defaultCenter];
    
    // 通知を行う
    [center postNotification:notification];
    
}

- (void)showLoginView {
   [self openSessionWithAllowLoginUI:YES];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // FBSample logic
    // We need to handle URLs by passing them to FBSession in order for SSO authentication
    // to work.
    return [FBSession.activeSession handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        [FBSession.activeSession close];
}

@end
