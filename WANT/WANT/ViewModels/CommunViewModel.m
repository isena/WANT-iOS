//
//  CommunViewModel.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "CommunViewModel.h"

@implementation CommunViewModel

#pragma mark - Lifecycle

- (id)init {
    NSAssert(NO, @"%@ must be initialized with a navigationController", self.class);
    return nil;
}

- (instancetype)initWithRouter:(id<IRouter>)router {
    NSParameterAssert(router);
    
    self = [super init];
    
    if (self) {
        _router = router;
    }
    
    return self;
}

@end
