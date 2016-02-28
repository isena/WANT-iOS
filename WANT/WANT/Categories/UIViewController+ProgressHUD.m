//
//  UIViewController+ProgressHUD.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "UIViewController+ProgressHUD.h"
#import "SVProgressHUD.h"

@implementation UIViewController (ProgressHUD)

#pragma mark - Public

- (void)showHUD {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(showHUD)
                               withObject:nil
                            waitUntilDone:YES];
        return;
    }
    
    [SVProgressHUD show];
}

- (void)dismissHUD {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(dismissHUD)
                               withObject:nil
                            waitUntilDone:YES];
        return;
    }
    
    [SVProgressHUD dismiss];
}

@end
