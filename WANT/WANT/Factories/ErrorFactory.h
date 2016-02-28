//
//  ErrorFactory.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WANTErrorDomainCode) {
    WANTErrorDomainCodeNotDefined,
    WANTErrorDomainCodeInvalidHTTPStatusCode,
    WANTErrorDomainCodeInvalidJSONResponse,
    WANTErrorDomainCodeAPIError,
    WANTErrorDomainCodeArrayIndexOutOfBounds
};

extern NSString *const WANTErrorDomain;

@interface ErrorFactory : NSObject

+ (NSError *)errorForDomainCode:(WANTErrorDomainCode)domainCode;

+ (NSError *)errorForDomainCode:(WANTErrorDomainCode)domainCode
              appendDescription:(NSString *)appendDescription;

@end

