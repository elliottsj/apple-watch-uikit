//
//  main.m
//  VanillaWatch
//
//  Created by Spencer Elliott on 2015-09-19.
//  Copyright © 2015 Spencer Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void __attribute__((constructor)) injected_main()
{
    @autoreleasepool {
        UIApplicationMain(0, nil, @"UIApplication", NSStringFromClass([AppDelegate class]));
    }
}
