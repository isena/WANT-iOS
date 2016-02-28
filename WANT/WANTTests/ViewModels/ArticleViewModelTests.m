//
//  ArticleViewModelTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Router.h"
#import <UIKit/UIKit.h>
#import "TestsHelper.h"
#import "ArticleViewModel.h"
#import "Article.h"
#import "ErrorFactory.h"
#import "HTTPStubs.h"

@interface ArticleViewModelTests : XCTestCase

@property (readonly, nonatomic, strong) Router *router;
@property (readonly, nonatomic, strong) Article *article;

@end

@implementation ArticleViewModelTests

- (void)setUp {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    _router = [[Router alloc] initWithNavigationController:navigationController];
    
    NSError *error;
    
    Article *article = [MTLJSONAdapter modelOfClass:Article.class
                                 fromJSONDictionary:[StubsFactory incompleteDictionaryForArticle]
                                              error:&error];
    XCTAssertNil(error);
    
    _article = article;
}

- (void)tearDown {
    [super tearDown];
    _router = nil;
    _article = nil;
    [HTTPStubs stop];
}

- (void)testShouldFailWhenCallInit {
    XCTAssertThrows([[ArticleViewModel alloc] init], @"Should fail if the init method is called");
}

- (void)testShouldFailWhenSendNilRouter {
    XCTAssertThrows([[ArticleViewModel alloc] initWithRouter:nil], @"Should fail if router isn't sent");
}

- (void)testShouldFailWhenOnlyRouterInit {
    XCTAssertThrows([[ArticleViewModel alloc] initWithRouter:self.router]);
}

- (void)testShouldInit {
    XCTAssertNotNil([[ArticleViewModel alloc] initWithRouter:self.router
                                                     article:self.article]);
}

- (void)testPerformTaskWithCompletionBlock {
    [HTTPStubs start];
    
    ArticleViewModel *viewModel = [[ArticleViewModel alloc] initWithRouter:self.router
                                                                   article:self.article];
    
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
