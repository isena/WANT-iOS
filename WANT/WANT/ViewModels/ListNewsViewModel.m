//
//  ListNewsViewModel.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ListNewsViewModel.h"
#import "ListNewsServices.h"
#import "Article.h"
#import "ArticleViewModel.h"
#import "APIRequestFactory.h"
#import "ErrorFactory.h"

@interface ListNewsViewModel ()

@property (strong, nonatomic) ListNewsServices *services;
@property (readonly, nonatomic, copy) NSArray *news;

@end

@implementation ListNewsViewModel

#pragma mark - Lifecycle

- (instancetype)initWithRouter:(id<IRouter>)router {
    NSAssert(NO, @"%@ must be initialized with mews array", self.class);
    return nil;
}

- (instancetype)initWithRouter:(id<IRouter>)router
                          news:(NSArray *)news {
    self = [super initWithRouter:router];
    
    if (self) {
        self.services = [[ListNewsServices alloc] init];
        _title = @"News";
        _news = [news copy];
    }
    
    return self;
}

#pragma mark - Tasks

- (void)performTaskNewsWithCompletionBlock:(CompletionBlock)completionBlock {
    [self.services taskRequestWithCompletionHandler:^(NSArray *news, NSError *error) {
        if (error) {
            completionBlock(error);
        } else {
            _news = [news copy];
            
            completionBlock(nil);
        }
    }];
}

- (void)performTaskToIndex:(NSInteger)index
           completionBlock:(CompletionBlock)completionBlock {
    if (index >= self.news.count) {
        NSError *error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeArrayIndexOutOfBounds];
        completionBlock(error);
        return;
    }
    
    Article *article = self.news[index];
    __block ArticleViewModel *viewModel;
    
    if (article.originalText) {
        viewModel = [[ArticleViewModel alloc] initWithRouter:self.router
                                                     article:article];
        
        [self.router pushViewModel:viewModel];
        
        completionBlock(nil);
    } else {
        [self.services taskRequestWithArticle:article
                            completionHandler:^(Article *article, NSError *error) {
                                if (error) {
                                    completionBlock(error);
                                } else {
                                    viewModel = [[ArticleViewModel alloc]
                                                 initWithRouter:self.router
                                                 article:article];
                                    
                                    [self.router pushViewModel:viewModel];
                                    
                                    completionBlock(nil);
                                }
                            }];
    }
}

#pragma mark - News Array Support

- (NSUInteger)countOfNews {
    return self.news.count;
}

- (NSString *)titleForIndex:(NSInteger)index {
    if (index < self.news.count) {
        Article *article = self.news[index];
        return article.title;
    } else {
        return @"--";
    }
}

@end
