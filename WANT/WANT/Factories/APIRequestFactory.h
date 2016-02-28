//
//  APIRequestFactory.h
//  WANT
//
//  Created by Isaac Stevao Sena on 14/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequestFactory : NSObject

+ (NSURLRequest *)requestForNews;

+ (NSURLRequest *)requestForArticleID:(NSString *)articleID;

+ (NSURLRequest *)requestForTranslateArticleID:(NSString *)articleID;

@end
