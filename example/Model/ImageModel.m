//
//  ImageModel.m
//  SimpleMapping
//
//  Created by iN on 31.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "ImageModel.h"
#import "AttributesModel.h"

#import "AFImageRequestOperation.h"

@implementation ImageModel

- (NSDictionary *)keyToPropertyNameReplacementRules {
    return @{@"label":@"url"};
}

- (NSDictionary *)keyToClassMappingRules {
    return @{@"attributes":[AttributesModel class]};
}

- (void)loadImageWithSuccessBlock:(SuccessGetImageBlock)successBlock {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    AFImageRequestOperation *operation;
    operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        _img = image;
        successBlock(image);
    }];
    [operation start];
}

@end
