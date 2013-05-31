//
//  FeedModel.h
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "BaseModel.h"

@class TitleModel;

@interface FeedModel : BaseModel
@property (nonatomic, strong) TitleModel *title;
@property (nonatomic, strong) NSArray *entry;
@end
