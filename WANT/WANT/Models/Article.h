//
//  Article.h
//  WANT
//
//  Created by Isaac Stevao Sena on 13/02/16.
//  Copyright © 2016 iSena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface Article : MTLModel <MTLJSONSerializing>

@property (readonly, nonatomic, copy) NSString *articleID;
@property (readonly, nonatomic, copy) NSString *apiUrl;
@property (readonly, nonatomic, copy) NSString *sectionID;
@property (readonly, nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *originalText;
@property (nonatomic, copy) NSString *tranlatedText;

@end
