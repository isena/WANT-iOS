//
//  ListNewsViewModelTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListNewsViewModel.h"
#import "Router.h"
#import <UIKit/UIKit.h>
#import "TestsHelper.h"
#import "Article.h"
#import "ErrorFactory.h"
#import "HTTPStubs.h"

@interface ListNewsViewModelTests : XCTestCase

@property (readonly, nonatomic, strong) Router *router;
@property (readonly, nonatomic, strong) NSArray *news;

@end

@implementation ListNewsViewModelTests

- (void)setUp {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    _router = [[Router alloc] initWithNavigationController:navigationController];
    
    NSError *error;
    
    Article *article = [MTLJSONAdapter modelOfClass:Article.class
                                 fromJSONDictionary:[StubsFactory incompleteDictionaryForArticle]
                                              error:&error];
    XCTAssertNil(error);
    
    _news = @[article];
}

- (void)tearDown {
    [super tearDown];
    _router = nil;
    _news = nil;
    [HTTPStubs stop];
}

- (void)testShouldFailWhenCallInit {
    XCTAssertThrows([[ListNewsViewModel alloc] init], @"Should fail if the init method is called");
}

- (void)testShouldFailWhenSendNilRouter {
    XCTAssertThrows([[ListNewsViewModel alloc] initWithRouter:nil], @"Should fail if router isn't sent");
}

- (void)testShouldFailWhenOnlyRouterInit {
    XCTAssertThrows([[ListNewsViewModel alloc] initWithRouter:self.router]);
}

- (void)testShouldInit {
    XCTAssertNotNil([[ListNewsViewModel alloc] initWithRouter:self.router
                                                         news:self.news]);
}

- (void)testPerformTaskNewsWithCompletionBlock {
    [HTTPStubs start];
    
    ListNewsViewModel *viewModel = [[ListNewsViewModel alloc] initWithRouter:self.router
                                                                        news:self.news];
    
    XCTAssertNotNil(viewModel);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPerformTaskNewsWithCompletionBlock expectation"];
    
    [viewModel performTaskNewsWithCompletionBlock:^(NSError *error) {
        XCTAssertNil(error, @"error should be nil: <%@>", error);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

- (void)testPerformTaskToIndexWithCompletionBlock {
    [HTTPStubs start];
    
    ListNewsViewModel *viewModel = [[ListNewsViewModel alloc] initWithRouter:self.router
                                                                        news:self.news];
    
    XCTAssertNotNil(viewModel);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPerformTaskToIndexWithCompletionBlock expectation"];
    
    [viewModel performTaskToIndex:0
                  completionBlock:^(NSError *error) {
                      XCTAssertNil(error, @"error should be nil: <%@>", error);
                      
                      [expectation fulfill];
                  }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

- (void)testPerformTaskToIndexWithCompletionBlockWithArrayIndexOutOfBoundsError {
    ListNewsViewModel *viewModel = [[ListNewsViewModel alloc] initWithRouter:self.router
                                                                        news:self.news];
    
    XCTAssertNotNil(viewModel);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPerformTaskToIndexWithCompletionBlockWithArrayIndexOutOfBoundsError expectation"];
    
    [viewModel performTaskToIndex:9999
                  completionBlock:^(NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertTrue([error.domain isEqualToString:WANTErrorDomain]);
        XCTAssertTrue(error.code == WANTErrorDomainCodeArrayIndexOutOfBounds);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

@end
