//
//  Router.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRouter.h"

@interface Router : NSObject <IRouter>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
