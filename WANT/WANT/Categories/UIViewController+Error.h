//
//  UIViewController+Error.h
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Error)

- (void)showError:(NSError *)error;

- (void)showError:(NSError *)error
      alertAction:(UIAlertAction *)alertAction;

@end
