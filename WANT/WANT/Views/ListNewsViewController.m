//
//  ListNewsViewController.m
//  WANT
//
//  Created by Isaac Stevao Sena on 13/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ListNewsViewController.h"
#import "Defaults.h"
#import "UIViewController+Categories.h"
#import "ListNewsViewModel.h"

@interface ListNewsViewController ()

@property (strong, nonatomic) ListNewsViewModel *viewModel;

@end

@implementation ListNewsViewController

#pragma mark - Lifecycle

- (instancetype)initWithViewModel:(id)viewModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:DefaultIdentifierStoryboardMain bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    
    if (self) {
        self.viewModel = viewModel;
        self.title = self.viewModel.title;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    _viewModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRefreshControl];
    
    [self.navigationItem setHidesBackButton:YES
                                   animated:NO];
}

#pragma mark - Privates

- (void)addRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
}

- (void)refresh {
    [self.viewModel performTaskNewsWithCompletionBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            
            if (error) {
                [self showError:error];
            } else {
                [self.tableView reloadData];
            }
        });
    }];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel countOfNews];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"ListCellIdentifier"];
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:777];

    label.text = [self.viewModel titleForIndex:indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showHUD];
    
    [self.viewModel performTaskToIndex:indexPath.row
                       completionBlock:^(NSError *error) {
                           [self dismissHUD];
                           
                           if (error) [self showError:error];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
