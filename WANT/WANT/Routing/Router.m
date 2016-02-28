//
//  Router
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "Router.h"
#import "ViewModels.h"
#import "ViewControllers.h"

@interface Router ()

@property (weak, nonatomic) UINavigationController *navigationController;

@end

@implementation Router

#pragma mark - Lifecycle

- (id)init {
    NSAssert(NO, @"%@ must be initialized with a navigationController", self.class);
    return nil;
}

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _navigationController = navigationController;
    }
    
    return self;
}

#pragma mark - IRouter Protocol Implementation

- (void)pushViewModel:(id)viewModel {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(pushViewModel:)
                               withObject:viewModel
                            waitUntilDone:YES];
        return;
    }
    
    id viewController = [self viewControllerToViewModel:viewModel];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Private

- (id)viewControllerToViewModel:(id)viewModel {
    id viewController;
    
    if ([viewModel isKindOfClass:ListNewsViewModel.class]) {
        viewController = [[ListNewsViewController alloc]
                          initWithViewModel:viewModel];
    } else if ([viewModel isKindOfClass:ArticleViewModel.class]) {
        viewController = [[ArticleViewController alloc]
                          initWithViewModel:viewModel];
    } else {
        NSAssert(NO, @"There is no viewController to viewModel <%@>", viewModel);
    }
    
    return viewController;
}

@end
