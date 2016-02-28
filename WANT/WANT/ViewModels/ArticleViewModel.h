//
//  ArticleViewModel.h
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "CommunViewModel.h"

@class Article;

@interface ArticleViewModel : CommunViewModel

@property (readonly, nonatomic, copy) NSString *text;
@property (readonly, nonatomic, copy) NSString *buttonTitle;
@property (readonly, nonatomic, copy) NSArray *segmentedControlTitles;
@property (readonly, nonatomic) NSInteger selectedSegmentIndex;

- (instancetype)initWithRouter:(id<IRouter>)router
                       article:(Article *)article;

- (void)performTaskWithCompletionBlock:(CompletionBlock)completionBlock;

@end
