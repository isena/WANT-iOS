//
//  CommunViewModelTests.m
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CommunViewModel.h"
#import "Router.h"
#import <UIKit/UIKit.h>

@interface CommunViewModelTests : XCTestCase

@end

@implementation CommunViewModelTests

- (void)testShouldFailWhenCallInit {
    XCTAssertThrows([[CommunViewModel alloc] init], @"Should fail if the init method is called");
}

- (void)testShouldFailWhenSendNilRouter {
    XCTAssertThrows([[CommunViewModel alloc] initWithRouter:nil], @"Should fail if router isn't sent");
}

- (void)testShouldInit {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    Router *router = [[Router alloc] initWithNavigationController:navigationController];
    XCTAssertNotNil([[CommunViewModel alloc] initWithRouter:router]);
}

@end
