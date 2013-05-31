//
//  EntityModel.m
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "EntryModel.h"
#import "TitleModel.h"
#import "ImageModel.h"

@implementation EntryModel

- (NSDictionary *)keyToClassMappingRules {
    return @{@"im:name":[TitleModel class],@"im:image":[ImageModel class]};
}

- (NSDictionary *)keyToPropertyNameReplacementRules {
    return @{@"im:name":@"name",@"im:image":@"images"};
}

@end
