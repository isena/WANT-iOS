//
//  InitialViewModel.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "InitialViewModel.h"
#import "InitialServices.h"
#import "ListNewsViewModel.h"

@interface InitialViewModel ()

@property (strong, nonatomic) InitialServices *services;

@end

@implementation InitialViewModel

#pragma mark - Lifecycle

- (instancetype)initWithRouter:(id<IRouter>)router {
    self = [super initWithRouter:router];
    
    if (self) {
        self.services = [[InitialServices alloc] init];
    }
    
    return self;
}

#pragma mark - Task

- (void)performTaskWithCompletionBlock:(CompletionBlock)completionBlock {
    [self.services taskRequestWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (error) {
            completionBlock(error);
        } else {
            ListNewsViewModel *viewModel = [[ListNewsViewModel alloc] initWithRouter:self.router
                                                                                news:news];
            
            [self.router pushViewModel:viewModel];
            
            completionBlock(nil);
        }
    }];
}

@end
