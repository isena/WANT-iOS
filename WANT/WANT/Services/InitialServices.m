//
//  InitialServices.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "InitialServices.h"
#import "APIRequestFactory.h"
#import "Services.h"
#import "Article.h"

@implementation InitialServices

#pragma mark - Task

- (void)taskRequestWithCompletionHandler:(NewsServiceCompletionBlock)completionBlock {
    [Services taskNewsRequestWithCompletionHandler:completionBlock];
}

@end
