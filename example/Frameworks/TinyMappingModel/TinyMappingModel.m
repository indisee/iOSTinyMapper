//
//  BaseModel.m
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "TinyMappingModel.h"

@implementation TinyMappingModel

+ (instancetype)mapObjectFromDictionary:(NSDictionary *)data {
    
    TinyMappingModel *model = [[self alloc] init];
    for (NSString *inputKey in [data allKeys]) {
        id value = data[inputKey];
        
        BOOL isArray = [value isKindOfClass:[NSArray class]];
        
        Class classToMap = [model keyToClassMappingRules][inputKey];
        
        NSString *propertyName = [[model keyToPropertyNameReplacementRules] valueForKey:inputKey];
        propertyName = propertyName?propertyName:inputKey;
        
        if (classToMap) {
            if (isArray){
                [model setValue:[classToMap mapArrayOfObjects:value] forKey:propertyName];
            } else {
                [model setValue:[classToMap mapObjectFromDictionary:value] forKey:propertyName];
            }
        } else {
            [model setValue:value forKey:propertyName];
        }
    }
    return model;
}

+ (NSArray *)mapArrayOfObjects:(NSArray *)data {
    
    NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:data.count];
    
    for (id value in data) {
        BOOL isArray = [value isKindOfClass:[NSArray class]];
        if (isArray) {
            [mappedArray addObject:[self mapArrayOfObjects:value]];
        } else {
            [mappedArray addObject:[self mapObjectFromDictionary:value]];
        }
    }
    
    return [NSArray arrayWithArray:mappedArray];
}

- (NSDictionary *)keyToClassMappingRules {
    return nil;
}

- (NSDictionary *)keyToPropertyNameReplacementRules {
    return nil;
}

#pragma mark - KVC

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

@end
