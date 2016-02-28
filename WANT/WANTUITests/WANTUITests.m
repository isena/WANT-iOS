//
//  WANTUITests.m
//  WANTUITests
//
//  Created by Isaac Stevao Sena on 13/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HTTPStubs.h"
#import "TestsHelper.h"

static int _index = 1;
static NSString *_partialOriginalText = @"More than 7 million children living in low-income families will be affected by a four-year freeze to their benefits that risks pushing many more into poverty, according to new research.";
static NSString *_partialTranslatedText = @"Mais de 7 milhões de crianças vivendo em famílias de baixa renda serão afetados por um congelamento de quatro anos para seus benefícios que os riscos empurrando muitos mais na pobreza, de acordo com novas pesquisas.";

@interface WANTUITests : XCTestCase

@property (strong, nonatomic) XCUIApplication *app;

@end

@implementation WANTUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    [HTTPStubs start];
}

- (void)tearDown {
    [super tearDown];
    [self.app terminate];
    [HTTPStubs stop];
}

- (void)testOriginalTextView {
    
    XCUIElementQuery *tables = self.app.tables;
    [[tables.element.cells elementBoundByIndex:_index] tap];
    
    XCUIElement *textView = self.app.textViews[@"textView"];
    
    XCTAssertTrue([textView.value rangeOfString:_partialOriginalText].location != NSNotFound);
}

- (void)testTranslatedTextView {
    XCUIElementQuery *tables = self.app.tables;
    [[tables.element.cells elementBoundByIndex:_index] tap];
    
    [self.app.segmentedControls.buttons[@"translated"] tap];
    
    XCUIElement *textView = self.app.textViews[@"textView"];
    
    XCTAssertTrue([textView.value rangeOfString:_partialTranslatedText].location != NSNotFound);
}

- (void)testOriginalAndTranslatedTextView {
    XCUIElementQuery *tables = self.app.tables;
    [[tables.element.cells elementBoundByIndex:_index] tap];
    
    XCUIElement *textView = self.app.textViews[@"textView"];
    
    XCTAssertTrue([textView.value rangeOfString:_partialOriginalText].location != NSNotFound);
    
    [self.app.segmentedControls.buttons[@"translated"] tap];
    
    textView = self.app.textViews[@"textView"];
    
    XCTAssertTrue([textView.value rangeOfString:_partialTranslatedText].location != NSNotFound);
}

@end
