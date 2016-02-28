//
//  IRouter.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRouter <NSObject>

- (void)pushViewModel:(id)viewModel;

@end
