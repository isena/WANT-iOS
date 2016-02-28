//
//  ArticleViewController.m
//  WANT
//
//  Created by Isaac Stevao Sena on 14/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ArticleViewController.h"
#import "Defaults.h"
#import "ArticleViewModel.h"

#import "UIViewController+Categories.h"

@interface ArticleViewController ()

@property (strong, nonatomic) ArticleViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation ArticleViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSegmentedControl];
    
    [self setUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.textView setContentOffset:CGPointZero
                           animated:NO];
}

#pragma mark - Privates

#pragma mark UI operation

- (void)addSegmentedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.viewModel.segmentedControlTitles];
    [self.segmentedControl sizeToFit];
    self.segmentedControl.selectedSegmentIndex = self.viewModel.selectedSegmentIndex;
    self.navigationItem.titleView = self.segmentedControl;
    [self.segmentedControl addTarget:self
                              action:@selector(action)
                    forControlEvents:UIControlEventValueChanged];
}

- (void)setUI {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(setUI)
                               withObject:nil
                            waitUntilDone:YES];
        return;
    }
    
    self.textView.text = self.viewModel.text;
    self.segmentedControl.selectedSegmentIndex = self.viewModel.selectedSegmentIndex;
}

#pragma mark UI action

- (void)action {
    [self showHUD];
    
    [self.viewModel performTaskWithCompletionBlock:^(NSError *error) {
        [self dismissHUD];
        
        if (error) [self showError:error];
        
        [self setUI];
    }];
}


@end
