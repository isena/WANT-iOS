//
//  HTTPStubs.m
//  WANT
//
//  Created by Isaac Stevao Sena on 16/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import "HTTPStubs.h"
#import "VCR.h"

@implementation HTTPStubs

#pragma mark - Public

+ (void)start {
    NSLog(@"starting stubs...");
    [VCR loadCassetteWithContentsOfURL:[self cassettePath]];
    [VCR start];
}

+ (void)stop {
    NSLog(@"stoping stubs...");
    [VCR stop];
}

#pragma mark - Private

+ (NSURL *)cassettePath {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"cassette"
                                      ofType:@"json"];
    return [NSURL fileURLWithPath:path];
}

@end
