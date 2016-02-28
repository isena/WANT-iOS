//
//  TestsHelper.h
//  WANT
//
//  Created by Isaac Stevao Sena on 2/16/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int HelperDefaultExpectationTimeout;

@interface StubsFactory : NSObject

+ (NSDictionary *)incompleteDictionaryForArticle;

@end
