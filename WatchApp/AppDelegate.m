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

+ (BOOL)isValidNumber:(NSString *)phone
{
    // getting a JSContext
    JSContext *context = [JSContext new];
    
    // defining a JavaScript function
    NSString *jsFunctionText =
    @"var isValidNumber = function(phone) {"
    "    var phonePattern = /^[0-9]{3}[ ][0-9]{3}[-][0-9]{4}$/;"
    "    return phone.match(phonePattern) ? true : false;"
    "}";
    [context evaluateScript:jsFunctionText];
    
    // calling a JavaScript function
    JSValue *jsFunction = context[@"isValidNumber"];
    JSValue *value = [jsFunction callWithArguments:@[ phone ]];
    
    return [value toBool];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *phoneNumber = @"416 967-1111";
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect bounds = mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

    BOOL isValidNumber = [AppDelegate isValidNumber:phoneNumber];
    UITextView *isPhoneNumberValidView = [[UITextView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    isPhoneNumberValidView.backgroundColor = [UIColor clearColor];
    isPhoneNumberValidView.textColor = [UIColor whiteColor];

    [isPhoneNumberValidView setText:isValidNumber ? @"Yep!" : @"Nope!"];
    [aView addSubview:isPhoneNumberValidView];
    
    aView.backgroundColor = [UIColor orangeColor];
    UIViewController *rootViewController = [[UIViewController alloc] init];
    rootViewController.view = aView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
