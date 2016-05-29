//
//  AppDelegate.m
//  AppleWatchUIKit
//
//  Created by Spencer Elliott on 2016-05-29.
//  Copyright © 2016 Spencer Elliott. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
     * Just drawing a blue rect
     */
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect bounds = mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    aView.backgroundColor = [UIColor greenColor];
    UIViewController *rootViewController = [[UIViewController alloc] init];
    rootViewController.view = aView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
