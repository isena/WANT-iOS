//
//  CommunViewModel.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRouter.h"

typedef void(^CompletionBlock)(NSError *error);

@interface CommunViewModel : NSObject

@property (readonly, weak, nonatomic) id<IRouter> router;

- (instancetype)initWithRouter:(id<IRouter>)router;

@end
