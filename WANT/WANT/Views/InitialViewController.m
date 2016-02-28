//
//  InitialViewController.m
//  WANT
//
//  Created by Isaac Stevao Sena on 13/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "InitialViewController.h"
#import "Article.h"
#import "ListNewsViewController.h"
#import "Defaults.h"

#import "InitialViewModel.h"

#import "UIViewController+Categories.h"

@interface InitialViewController ()

@property (strong, nonatomic) InitialViewModel *viewModel;

@end

@implementation InitialViewController

#pragma mark - Lifecycle

- (instancetype)initWithViewModel:(id)viewModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:DefaultIdentifierStoryboardMain bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    _viewModel = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self listNews];
}

#pragma mark - Private

- (void)listNews {
    [self showHUD];
    
    [self.viewModel performTaskWithCompletionBlock:^(NSError *error) {
        [self dismissHUD];
        if (error) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"try again"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                    [self listNews];
                                                                }];
            
            [self showError:error
                alertAction:alertAction];
        }
    }];
}

@end
