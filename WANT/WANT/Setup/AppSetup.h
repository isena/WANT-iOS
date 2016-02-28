//
//  AppSetup.h
//  WANT
//
//  Created by Isaac Stevao Sena on 2/17/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppSetup : NSObject

+ (instancetype)sharedInstance;

- (UINavigationController *)initialNavigationController;

- (NSString *)host;

@end
