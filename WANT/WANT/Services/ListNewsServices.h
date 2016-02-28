//
//  ListNewsServices.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Services.h"

@class Article;

@interface ListNewsServices : NSObject

- (void)taskRequestWithCompletionHandler:(NewsServiceCompletionBlock)completionBlock;

- (void)taskRequestWithArticle:(Article *)article
             completionHandler:(ArticleServiceCompletionBlock)completionBlock;

@end
