//
//  AppDelegate.m
//  VanillaWatch
//
//  Created by Spencer Elliott on 2015-09-19.
//  Copyright © 2015 Spencer Elliott. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    JSContext *context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    context[@"a"] = @5;
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect bounds = mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    aView.backgroundColor = [UIColor orangeColor];
    UIViewController *rootViewController = [[UIViewController alloc] init];
    rootViewController.view = aView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
