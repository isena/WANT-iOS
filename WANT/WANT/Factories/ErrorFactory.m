//
//  ErrorFactory.m
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "ErrorFactory.h"

static NSDictionary *_descriptions;

NSString *const WANTErrorDomain = @"WANTErrorDomain";

@implementation ErrorFactory

#pragma mark - Public

+ (NSError *)errorForDomainCode:(WANTErrorDomainCode)domainCode {
    return [self errorForDomainCode:domainCode appendDescription:nil];
}

+ (NSError *)errorForDomainCode:(WANTErrorDomainCode)domainCode
              appendDescription:(NSString *)appendDescription {
    NSString *description = [self descriptionToDomainCode:domainCode];
    
    if (appendDescription && [appendDescription length] > 0) {
        description = [NSString stringWithFormat:@"%@ %@", description, appendDescription];
    }
    
    NSError *error = [NSError errorWithDomain:WANTErrorDomain
                                         code:domainCode
                                     userInfo:@{NSLocalizedDescriptionKey : description}];
    
    return error;
}

#pragma mark - Support

+ (NSString *)descriptionToDomainCode:(WANTErrorDomainCode)domainCode {
    if (domainCode < WANTErrorDomainCodeNotDefined || domainCode > WANTErrorDomainCodeArrayIndexOutOfBounds) {
        domainCode = WANTErrorDomainCodeNotDefined;
    }
    
    return [self descriptions][@(domainCode)];
}

#pragma mark - Lazy instantiation

+ (NSDictionary *)descriptions {
    if (!_descriptions) {
        _descriptions = @{@(WANTErrorDomainCodeNotDefined) : @"not defined :(",
                          @(WANTErrorDomainCodeInvalidHTTPStatusCode) : @"Invalid HTTP status code :(",
                          @(WANTErrorDomainCodeInvalidJSONResponse) : @"Response is not a valid JSON :(",
                          @(WANTErrorDomainCodeAPIError) : @"Something bad happened in our service :(",
                          @(WANTErrorDomainCodeArrayIndexOutOfBounds) : @"Index out of bounds :("};
    }
    return _descriptions;
}

@end
