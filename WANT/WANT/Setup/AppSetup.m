//
//  AppSetup.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/17/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "AppSetup.h"
#import "HTTPStubs.h"
#import "Router.h"
#import "InitialViewModel.h"
#import "InitialViewController.h"

static AppSetup *_sharedInstance = nil;
static NSString *_host = @"http://replace.yourhost.com";

@interface AppSetup ()

@property (strong, nonatomic) Router *router;
@property (readonly, nonatomic) BOOL useLocalHost;

@end

@implementation AppSetup

#pragma mark - Shared Instance

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        [self setup];
    }
    return self;
}

#pragma mark - Public

- (UINavigationController *)initialNavigationController {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0
                                                                      green:0
                                                                       blue:100./255
                                                                      alpha:1];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIViewController *viewController = [self initialViewControllerWithNavigationController:navigationController];
    
    [navigationController pushViewController:viewController animated:NO];
    
    return navigationController;
}

- (NSString *)host {
    return _host;
}

#pragma mark - Privates

- (void)setup {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self customSetup];
}

- (void)customSetup {
    [self useStubs:YES];
}

- (void)useStubs:(BOOL)use {
    if (use) {
        [HTTPStubs start];
    } else {
        [HTTPStubs stop];
    }
}

- (UIViewController *)initialViewControllerWithNavigationController:(UINavigationController *)navigationController {
    self.router = [[Router alloc] initWithNavigationController:navigationController];
    InitialViewModel *viewModel = [[InitialViewModel alloc] initWithRouter:self.router];
    return [[InitialViewController alloc] initWithViewModel:viewModel];
}

@end
