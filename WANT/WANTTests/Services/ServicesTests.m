//
//  ServicesTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Services.h"
#import "TestsHelper.h"
#import "ErrorFactory.h"
#import "Article.h"
#import "HTTPStubs.h"

@interface ServicesTests : XCTestCase

@property (readonly, nonatomic, strong) Article *article;

@end

@implementation ServicesTests

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

- (void)testTaskNewsRequest {
    [HTTPStubs start];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskNewsRequest expectation"];
    
    [Services taskNewsRequestWithCompletionHandler:^(NSArray *news, NSError *error) {
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

- (void)testTaskRequestCompleteArticle {
    [HTTPStubs start];
    
    XCTAssertNil(self.article.originalText, @"originalText should be nil: <%@>", self.article.originalText);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskRequestCompleteArticle expectation"];
    
    [Services taskRequestCompleteArticle:self.article
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

- (void)testTaskRequestTranslateArticle {
    [HTTPStubs start];
    
    XCTAssertNil(self.article.tranlatedText, @"tranlatedText should be nil: <%@>", self.article.tranlatedText);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskRequestTranslateArticle expectation"];
    
    [Services taskRequestTranslateArticle:self.article
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
