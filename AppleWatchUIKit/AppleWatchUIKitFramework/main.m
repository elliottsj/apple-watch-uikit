//
//  main.m
//  AppleWatchUIKit
//
//  Created by Spencer Elliott on 2016-05-29.
//  Copyright © 2016 Spencer Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void __attribute__((constructor)) injected_main()
{
    @autoreleasepool {
        UIApplicationMain(0, nil, @"UIApplication", NSStringFromClass([AppDelegate class]));
    }
}
