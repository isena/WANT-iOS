//
//  ArticleServicesTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArticleServices.h"
#import "TestsHelper.h"
#import "ErrorFactory.h"
#import "Article.h"
#import "HTTPStubs.h"

@interface ArticleServicesTests : XCTestCase

@property (readonly, nonatomic, strong) Article *article;

@end

@implementation ArticleServicesTests

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
    
    ArticleServices *services = [[ArticleServices alloc] init];
    
    XCTAssertNil(self.article.tranlatedText, @"tranlatedText should be nil: <%@>", self.article.tranlatedText);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskRequest expectation"];
    
    [services taskRequestWithArticle:self.article
                   completionHandler:^(Article *article, NSError *error) {
                       XCTAssertNil(error, @"error should be nil: <%@>", error);
                       XCTAssertNotNil(article);
                       XCTAssertNotNil(article.tranlatedText);
                       
                       [expectation fulfill];
                   }];
    
    [self waitForExpectationsWithTimeout:HelperDefaultExpectationTimeout
                                 handler:^(NSError *error) {
                                     NSLog(@"error: <%@>", error);
                                 }];
}

@end
