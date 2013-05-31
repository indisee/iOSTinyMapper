//
//  EntityModel.h
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "BaseModel.h"
@class TitleModel;
@interface EntryModel : BaseModel
@property (nonatomic, strong) TitleModel *name;
@property (nonatomic, strong) NSArray *images;
@end
