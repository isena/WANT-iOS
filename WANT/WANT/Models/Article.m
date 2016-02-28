//
//  Article.m
//  WANT
//
//  Created by Isaac Stevao Sena on 13/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "Article.h"

@implementation Article

#pragma mark - Mantle Transformers

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"articleID": @"id",
             @"apiUrl": @"apiUrl",
             @"sectionID": @"sectionId",
             @"title": @"webTitle",
             @"originalText": @"originalText",
             @"tranlatedText": @"tranlatedText"
             };
}

@end
