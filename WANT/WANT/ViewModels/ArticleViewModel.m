//
//  ArticleViewModel.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ArticleViewModel.h"
#import "ArticleServices.h"
#import "Article.h"

static int const _originalIndex = 0;
static int const _translatedIndex = 1;

@interface ArticleViewModel () {
    BOOL _showingTranslatedText;
}

@property (strong, nonatomic) ArticleServices *services;
@property (strong, nonatomic) Article *article;

@end

@implementation ArticleViewModel

#pragma mark - Lifecycle

- (instancetype)initWithRouter:(id<IRouter>)router {
    NSAssert(NO, @"%@ must be initialized with mews array", self.class);
    return nil;
}

- (instancetype)initWithRouter:(id<IRouter>)router
                       article:(Article *)article {
    self = [super initWithRouter:router];
    
    if (self) {
        self.services = [[ArticleServices alloc] init];
        _article = [article copy];
        _text = [article.originalText copy];
        _buttonTitle = @"translate";
        _segmentedControlTitles = @[@"original", @"translated"];
        _selectedSegmentIndex = _originalIndex;
    }
    
    return self;
}

#pragma mark - Task

- (void)performTaskWithCompletionBlock:(CompletionBlock)completionBlock {
    if (_showingTranslatedText) {
        _text = [self.article.originalText copy];
        [self showingTranslatedText:NO];
        completionBlock(nil);
    } else if (self.article.tranlatedText && self.article.tranlatedText.length > 0) {
        _text = [self.article.tranlatedText copy];
        [self showingTranslatedText:YES];
        completionBlock(nil);
    } else {
        [self.services taskRequestWithArticle:self.article
                            completionHandler:^(Article *article, NSError *error) {
                                if (error) {
                                    [self showingTranslatedText:_showingTranslatedText];
                                    completionBlock(error);
                                } else {
                                    _text = [self.article.tranlatedText copy];
                                    [self showingTranslatedText:YES];
                                    completionBlock(nil);
                                }
                            }];
    }
}

#pragma mark - Private

- (void)showingTranslatedText:(BOOL)showing {
    _showingTranslatedText = showing;
    _selectedSegmentIndex = showing ? _translatedIndex  : _originalIndex;
}

@end
