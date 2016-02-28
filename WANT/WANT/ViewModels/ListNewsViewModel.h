//
//  ListNewsViewModel.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "CommunViewModel.h"
#import "IRouter.h"

@interface ListNewsViewModel : CommunViewModel

@property (readonly, nonatomic, copy) NSString *title;

- (instancetype)initWithRouter:(id<IRouter>)router
                          news:(NSArray *)news;

- (void)performTaskNewsWithCompletionBlock:(CompletionBlock)completionBlock;

- (void)performTaskToIndex:(NSInteger)index
           completionBlock:(CompletionBlock)completionBlock;

- (NSString *)titleForIndex:(NSInteger)index;

- (NSUInteger)countOfNews;

@end
