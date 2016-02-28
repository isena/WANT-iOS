//
//  Services.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "Services.h"
#import "ErrorFactory.h"
#import "APIRequestFactory.h"
#import "Article.h"

typedef void(^ServicesCompletionBlock)(id result, NSError *error);

@implementation Services

#pragma mark - Tasks

+ (void)taskNewsRequestWithCompletionHandler:(NewsServiceCompletionBlock)completionBlock {
    NSURLRequest *request = [APIRequestFactory requestForNews];
    
    [self taskRequest:request
    completionHandler:^(id result, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        } else {
            NSArray *array = [MTLJSONAdapter modelsOfClass:Article.class
                                             fromJSONArray:result
                                                     error:&error];
            completionBlock(array, error);
        }
    }];
}

+ (void)taskRequestCompleteArticle:(Article *)article
                 completionHandler:(ArticleServiceCompletionBlock)completionBlock {
    NSURLRequest *request = [APIRequestFactory requestForArticleID:article.articleID];
    
    [Services taskRequest:request
        completionHandler:^(id result, NSError *error) {
            if (error) {
                completionBlock(nil, error);
            } else {
                article.originalText = result[@"originalText"];
                article.tranlatedText = result[@"translatedText"];
                completionBlock(article, nil);
            }
        }];
}

+ (void)taskRequestTranslateArticle:(Article *)article
                  completionHandler:(ArticleServiceCompletionBlock)completionBlock {
    NSURLRequest *request = [APIRequestFactory requestForTranslateArticleID:article.articleID];
    
    [Services taskRequest:request
        completionHandler:^(id result, NSError *error) {
            if (error) {
                completionBlock(nil, error);
            } else {
                article.tranlatedText = result[@"translatedText"];
                completionBlock(article, nil);
            }
        }];
}

#pragma mark - Privates

+ (void)taskRequest:(NSURLRequest *)request
  completionHandler:(ServicesCompletionBlock)completionBlock {
    NSParameterAssert(request);
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    
                    NSInteger statusCode = [httpResponse statusCode];
                    
                    if (error) {
                        completionBlock(nil, error);
                    } else if (statusCode != 200) {
                        NSString *string = [NSString stringWithFormat:@"status code =  %ld.", (long)statusCode];
                        
                        NSError *error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeInvalidHTTPStatusCode
                                                           appendDescription:string];
                        
                        completionBlock(nil, error);
                    } else {
                        [self resultForData:data
                          completionHandler:completionBlock];
                    }
                }] resume];
}

+ (void)resultForData:(NSData *)data
    completionHandler:(ServicesCompletionBlock)completionBlock {
    NSError *error = nil;
    
    id result = nil;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
    
    if (error) {
        NSString *string = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
        
        error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeInvalidJSONResponse
                                  appendDescription:string];
        
    } else {
        BOOL success = [dictionary[@"success"] boolValue];
        
        if (success) {
            result = dictionary[@"result"];
        } else {
            id errorJSON = dictionary[@"result"][@"error"];
            
            NSString *string = nil;
            
            if ([errorJSON respondsToSelector:@selector(description)]) {
                string = [errorJSON description];
            }
            
            error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeAPIError
                                      appendDescription:string];
        }
    }
    
    completionBlock(result, error);
}

@end
