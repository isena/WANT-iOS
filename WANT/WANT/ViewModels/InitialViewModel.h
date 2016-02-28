//
//  InitialViewModel.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunViewModel.h"

@interface InitialViewModel : CommunViewModel

- (void)performTaskWithCompletionBlock:(CompletionBlock)completionBlock;

@end
