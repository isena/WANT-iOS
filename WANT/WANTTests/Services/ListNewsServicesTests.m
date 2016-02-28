//
//  ListNewsServicesTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListNewsServices.h"
#import "TestsHelper.h"
#import "ErrorFactory.h"
#import "Article.h"
#import "HTTPStubs.h"

@interface ListNewsServicesTests : XCTestCase

@property (readonly, nonatomic, strong) Article *article;

@end

@implementation ListNewsServicesTests

- (void)setUp {
    NSError *error;
    
    Article *article = [MTLJSONAdapter modelOfClass:Article.class
                                 fromJSONDictionary:[StubsFactory incompleteDictionaryForArticle]
                                              error:&error];
    XCTAssertNil(error);
    
    _article = article;
}

- (void)tearDown {
    [super tearDown];
    _article = nil;
    [HTTPStubs stop];
}

- (void)testTaskRequest {
    [HTTPStubs start];
    
    ListNewsServices *services = [[ListNewsServices alloc] init];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskRequest expectation"];
    
    [services taskRequestWithCompletionHandler:^(NSArray *news, NSError *error) {
        XCTAssertNil(error, @"error should be nil: <%@>", error);
        XCTAssertNotNil(news);
        XCTAssertTrue(news.count > 0);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

- (void)testTaskRequestWithArticle {
    [HTTPStubs start];
    
    ListNewsServices *services = [[ListNewsServices alloc] init];
    
    XCTAssertNil(self.article.originalText, @"originalText should be nil: <%@>", self.article.originalText);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskRequestWithArticle expectation"];
    
    [services taskRequestWithArticle:self.article
                   completionHandler:^(Article *article, NSError *error) {
                       XCTAssertNil(error, @"error should be nil: <%@>", error);
                       XCTAssertNotNil(article);
                       XCTAssertNotNil(article.originalText);
                       
                       [expectation fulfill];
                   }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

@end
