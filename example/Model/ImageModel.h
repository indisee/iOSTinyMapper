//
//  ImageModel.h
//  SimpleMapping
//
//  Created by iN on 31.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "BaseModel.h"

@class AttributesModel;

typedef void(^SuccessGetImageBlock)(UIImage *img);

@interface ImageModel : BaseModel
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) AttributesModel *attributes;
@property (nonatomic, strong) UIImage *img;

- (void)loadImageWithSuccessBlock:(SuccessGetImageBlock)successBlock;
@end
