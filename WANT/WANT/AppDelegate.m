//
//  AppDelegate.m
//  WANT
//
//  Created by Isaac Stevao Sena on 13/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppSetup.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[AppSetup sharedInstance] initialNavigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
