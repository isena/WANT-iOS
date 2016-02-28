//
//  TestsHelper.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "TestsHelper.h"
#import "Article.h"

const int HelperDefaultExpectationTimeout = 30;

@implementation StubsFactory

+ (NSDictionary *)incompleteDictionaryForArticle {
    static NSDictionary *_incompleteDictionary;
    
    if (!_incompleteDictionary) {
        _incompleteDictionary = @{@"apiUrl" : @"http://content.guardianapis.com/business/2016/feb/23/vienna-named-worlds-top-city-for-quality-of-life",
                                  @"id" : @"business/2016/feb/23/vienna-named-worlds-top-city-for-quality-of-life",
                                  @"sectionId" : @"business",
                                  @"sectionName" : @"Business",
                                  @"type" : @"article",
                                  @"webPublicationDate" : @"2016-02-23T00:01:21Z",
                                  @"webTitle" : @"Two climbers missing on Ben Nevis",
                                  @"webUrl" : @"http://www.theguardian.com/business/2016/feb/23/vienna-named-worlds-top-city-for-quality-of-life"};
    }
    
    return [_incompleteDictionary copy];
}

@end
