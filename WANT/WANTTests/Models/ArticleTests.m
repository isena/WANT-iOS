//
//  ArticleTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Article.h"
#import "TestsHelper.h"

@interface ArticleTests : XCTestCase

@property (readonly, nonatomic, strong) NSDictionary *incompleteDictionary;
@property (readonly, nonatomic, strong) NSDictionary *completeDictionary;

@end

@implementation ArticleTests

- (void)setUp {
    _incompleteDictionary = [StubsFactory incompleteDictionaryForArticle];
    
    NSDictionary *dictionaryToComplete = @{@"originalText" : @"Rescuers are searching for two climbers who have gone missing on Ben Nevis...",
                                           @"tranlatedText" : @"Os bombeiros estão procurando dois alpinistas que desapareceram na Ben Nevis..."};
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self.incompleteDictionary];
    
    [dictionary addEntriesFromDictionary:dictionaryToComplete];
    
    _completeDictionary = [dictionary copy];
}

- (void)tearDown {
    [super tearDown];
    
    _incompleteDictionary = nil;
    _completeDictionary = nil;
}

- (void)testShouldBeAbleToParseAValidAndIncompleteDictionary {
    NSError *error;
    
    Article *article = [MTLJSONAdapter modelOfClass:Article.class
                                 fromJSONDictionary:self.incompleteDictionary
                                              error:&error];
    
    XCTAssertNil(error, @"error should not be nil: <%@>", error);
    XCTAssertNotNil(article, @"article should not be nil");
    XCTAssertTrue([article.articleID isEqualToString:self.incompleteDictionary[@"id"]]);
    XCTAssertTrue([article.apiUrl isEqualToString:self.incompleteDictionary[@"apiUrl"]]);
    XCTAssertTrue([article.sectionID isEqualToString:self.incompleteDictionary[@"sectionId"]]);
    XCTAssertTrue([article.title isEqualToString:self.incompleteDictionary[@"webTitle"]]);
    XCTAssertNil(article.originalText, @"article.originalText <%@> should be nil", article.originalText);
    XCTAssertNil(article.tranlatedText, @"article.tranlatedText <%@> should be nil", article.tranlatedText);
}

- (void)testShouldBeAbleToParseAValidAndCompleteDictionary {
    NSError *error;
    
    Article *article = [MTLJSONAdapter modelOfClass:Article.class
                                 fromJSONDictionary:self.completeDictionary
                                              error:&error];
    
    XCTAssertNil(error, @"error should not be nil: <%@>", error);
    XCTAssertNotNil(article, @"article should not be nil");
    XCTAssertTrue([article.articleID isEqualToString:self.completeDictionary[@"id"]]);
    XCTAssertTrue([article.apiUrl isEqualToString:self.completeDictionary[@"apiUrl"]]);
    XCTAssertTrue([article.sectionID isEqualToString:self.completeDictionary[@"sectionId"]]);
    XCTAssertTrue([article.title isEqualToString:self.completeDictionary[@"webTitle"]]);
    XCTAssertTrue([article.originalText isEqualToString:self.completeDictionary[@"originalText"]]);
    XCTAssertTrue([article.tranlatedText isEqualToString:self.completeDictionary[@"tranlatedText"]]);
}

@end
