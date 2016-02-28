//
//  UIViewController+Error.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "UIViewController+Error.h"

@implementation UIViewController (Error)

#pragma mark - Public

- (void)showError:(NSError *)error {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    
    [self showError:error
        alertAction:alertAction];
}

- (void)showError:(NSError *)error
      alertAction:(UIAlertAction *)alertAction {
    NSLog(@"error: %@", error);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:error.description
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:alertAction];
    
    [self presentViewController:alertController];
}

#pragma mark - Private
                   
- (void)presentViewController:(UIViewController *)viewController {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(presentViewController:)
                               withObject:viewController
                            waitUntilDone:YES];
        return;
    }
    
    [self presentViewController:viewController
                       animated:YES
                     completion:nil];
}

@end
