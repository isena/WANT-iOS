//
//  RouterTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Router.h"
#import <UIKit/UIKit.h>

@interface RouterTests : XCTestCase

@end

@implementation RouterTests

- (void)testShouldFailWhenCallInit {
    XCTAssertThrows([[Router alloc] init], @"Should fail if the init method is called");
}

- (void)testShouldInit {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    XCTAssertNotNil([[Router alloc] initWithNavigationController:navigationController]);
}

@end
