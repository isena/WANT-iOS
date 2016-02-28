//
//  InitialServices.h
//  WANT
//
//  Created by Isaac Stevao Sena on 15/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Services.h"

@interface InitialServices : NSObject

- (void)taskRequestWithCompletionHandler:(NewsServiceCompletionBlock)completionBlock;

@end
