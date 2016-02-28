//
//  ListNewsServices.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ListNewsServices.h"
#import "APIRequestFactory.h"
#import "Services.h"
#import "Article.h"

@implementation ListNewsServices

#pragma mark - Tasks

- (void)taskRequestWithCompletionHandler:(NewsServiceCompletionBlock)completionBlock {
    [Services taskNewsRequestWithCompletionHandler:completionBlock];
}

- (void)taskRequestWithArticle:(Article *)article
             completionHandler:(ArticleServiceCompletionBlock)completionBlock {
    [Services taskRequestCompleteArticle:article
                       completionHandler:completionBlock];
}

@end
