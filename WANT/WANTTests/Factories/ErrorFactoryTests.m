//
//  ErrorFactoryTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ErrorFactory.h"

@interface ErrorFactoryTests : XCTestCase

@end

@implementation ErrorFactoryTests

- (void)testShouldBeAnInvalidHTTPStatusCodeWANTError {
    NSError *error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeInvalidHTTPStatusCode];
    XCTAssertTrue([error.domain isEqualToString:WANTErrorDomain]);
    XCTAssertTrue(error.code == WANTErrorDomainCodeInvalidHTTPStatusCode);
}

- (void)testShouldBeAnInvalidJSONResponseWANTError {
    NSError *error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeInvalidJSONResponse];
    XCTAssertTrue([error.domain isEqualToString:WANTErrorDomain]);
    XCTAssertTrue(error.code == WANTErrorDomainCodeInvalidJSONResponse);
}

- (void)testShouldBeAnAPIWANTError {
    NSError *error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeAPIError];
    XCTAssertTrue([error.domain isEqualToString:WANTErrorDomain]);
    XCTAssertTrue(error.code == WANTErrorDomainCodeAPIError);
}

- (void)testShouldBeAnArrayIndexOutOfBounds {
    NSError *error = [ErrorFactory errorForDomainCode:WANTErrorDomainCodeArrayIndexOutOfBounds];
    XCTAssertTrue([error.domain isEqualToString:WANTErrorDomain]);
    XCTAssertTrue(error.code == WANTErrorDomainCodeArrayIndexOutOfBounds);
}

@end
