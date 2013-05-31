//
//  FeedModel.m
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "FeedModel.h"
#import "TitleModel.h"
#import "EntryModel.h"

@implementation FeedModel

- (NSDictionary *)keyToClassMappingRules {
    return @{@"title":[TitleModel class],@"entry":[EntryModel class]};
}

@end
