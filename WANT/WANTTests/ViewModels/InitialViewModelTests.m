//
//  InitialViewModelTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InitialViewModel.h"
#import "Router.h"
#import <UIKit/UIKit.h>
#import "TestsHelper.h"
#import "ErrorFactory.h"
#import "HTTPStubs.h"

@interface InitialViewModelTests : XCTestCase

@property (readonly, nonatomic, strong) Router *router;

@end

@implementation InitialViewModelTests

- (void)setUp {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    _router = [[Router alloc] initWithNavigationController:navigationController];
}

- (void)tearDown {
    [super tearDown];
    _router = nil;
    [HTTPStubs stop];
}

- (void)testShouldFailWhenCallInit {
    XCTAssertThrows([[InitialViewModel alloc] init], @"Should fail if the init method is called");
}

- (void)testShouldFailWhenSendNilRouter {
    XCTAssertThrows([[InitialViewModel alloc] initWithRouter:nil], @"Should fail if router isn't sent");
}

- (void)testShouldInit {
    XCTAssertNotNil([[InitialViewModel alloc] initWithRouter:self.router]);
}

- (void)testPerformTaskWithCompletionBlock {
    [HTTPStubs start];
    
    InitialViewModel *viewModel = [[InitialViewModel alloc] initWithRouter:self.router];
    
    XCTAssertNotNil(viewModel);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPerformTaskWithCompletionBlock expectation"];
    
    [viewModel performTaskWithCompletionBlock:^(NSError *error) {
        XCTAssertNil(error, @"error should be nil: <%@>", error);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

@end
