//
//  InitialServicesTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InitialServices.h"
#import "TestsHelper.h"
#import "ErrorFactory.h"
#import "HTTPStubs.h"

@interface InitialServicesTests : XCTestCase

@end

@implementation InitialServicesTests

- (void)tearDown {
    [super tearDown];
    [HTTPStubs stop];
}

- (void)testTaskNewsRequest {
    [HTTPStubs start];
    
    InitialServices *services = [[InitialServices alloc] init];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"testTaskNewsRequest expectation"];
    
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

@end
