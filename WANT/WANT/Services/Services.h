//
//  Services.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Article;

typedef void(^NewsServiceCompletionBlock)(NSArray *news, NSError *error);

typedef void(^ArticleServiceCompletionBlock)(Article *article, NSError *error);

@interface Services : NSObject

+ (void)taskNewsRequestWithCompletionHandler:(NewsServiceCompletionBlock)completionBlock;

+ (void)taskRequestCompleteArticle:(Article *)article
                 completionHandler:(ArticleServiceCompletionBlock)completionBlock;

+ (void)taskRequestTranslateArticle:(Article *)article
                  completionHandler:(ArticleServiceCompletionBlock)completionBlock;

@end
