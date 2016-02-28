//
//  ArticleServices.h
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Article;

typedef void(^ArticleServicesCompletionBlock)(Article *article, NSError *error);

@interface ArticleServices : NSObject

- (void)taskRequestWithArticle:(Article *)article
             completionHandler:(ArticleServicesCompletionBlock)completionBlock;

@end
