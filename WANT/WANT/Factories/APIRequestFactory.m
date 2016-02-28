//
//  APIRequestFactory.m
//  WANT
//
//  Created by Isaac Stevao Sena on 14/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "APIRequestFactory.h"
#import "AppSetup.h"

@implementation APIRequestFactory

+ (NSURLRequest *)requestForNews {
    NSString *string = [NSString stringWithFormat:@"%@/%@", [[AppSetup sharedInstance] host], @"api/news"];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

+ (NSURLRequest *)requestForArticleID:(NSString *)articleID {
    NSData *data = [articleID dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    NSString *string = [NSString stringWithFormat:@"%@/%@/%@", [[AppSetup sharedInstance] host], @"api/news", base64];
    NSURL *url = [NSURL URLWithString:[self encodedString:string]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

+ (NSURLRequest *)requestForTranslateArticleID:(NSString *)articleID {
    NSData *data = [articleID dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    NSString *string = [NSString stringWithFormat:@"%@/%@/%@", [[AppSetup sharedInstance] host], @"api/translate", base64];
    NSURL *url = [NSURL URLWithString:[self encodedString:string]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

+ (NSString *)encodedString:(NSString *)string {
    return [string stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

@end
