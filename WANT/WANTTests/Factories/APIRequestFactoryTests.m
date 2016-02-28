//
//  APIRequestFactoryTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIRequestFactory.h"
#import "Defaults.h"

@interface APIRequestFactoryTests : XCTestCase

@end

@implementation APIRequestFactoryTests

- (void)testRequestForNews {
    NSURLRequest *request = [APIRequestFactory requestForNews];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:@"http://replace.yourhost.com/api/news"]);
}

- (void)testRequestForArticleID {
    NSURLRequest *request = [APIRequestFactory requestForArticleID:@"uk-news/2016/feb/16/tim-newton-rachel-slater-climbers-missing-ben-nevis-mountain"];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:@"http://replace.yourhost.com/api/news/dWstbmV3cy8yMDE2L2ZlYi8xNi90aW0tbmV3dG9uLXJhY2hlbC1zbGF0ZXItY2xpbWJlcnMtbWlzc2luZy1iZW4tbmV2aXMtbW91bnRhaW4="]);
}

- (void)testRequestForTranslateArticleID {
    NSURLRequest *request = [APIRequestFactory requestForTranslateArticleID:@"uk-news/2016/feb/16/tim-newton-rachel-slater-climbers-missing-ben-nevis-mountain"];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:@"http://replace.yourhost.com/api/translate/dWstbmV3cy8yMDE2L2ZlYi8xNi90aW0tbmV3dG9uLXJhY2hlbC1zbGF0ZXItY2xpbWJlcnMtbWlzc2luZy1iZW4tbmV2aXMtbW91bnRhaW4="]);
}

@end
