//
//  BaseModel.h
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TinyMappingModel : NSObject

+ (instancetype)mapObjectFromDictionary:(NSDictionary *)data;
+ (NSArray *)mapArrayOfObjects:(NSArray *)data;

//protected methods
- (NSDictionary *)keyToClassMappingRules;
- (NSDictionary *)keyToPropertyNameReplacementRules;

@end
