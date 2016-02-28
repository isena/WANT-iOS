//
//  ArticleServices.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ArticleServices.h"
#import "Article.h"
#import "APIRequestFactory.h"
#import "Services.h"

@implementation ArticleServices

#pragma mark - Task

- (void)taskRequestWithArticle:(Article *)article
             completionHandler:(ArticleServicesCompletionBlock)completionBlock {
    [Services taskRequestTranslateArticle:article
                        completionHandler:completionBlock];
}

@end
