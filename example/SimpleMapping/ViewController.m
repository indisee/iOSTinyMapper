//
//  ViewController.m
//  SimpleMapping
//
//  Created by iN on 20.05.13.
//  Copyright (c) 2013 Cats. All rights reserved.
//

#import "ViewController.h"

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

#import "FeedModel.h"
#import "TitleModel.h"
#import "EntryModel.h"
#import "ImageModel.h"

#define kBaseURL    @"http://phobos.apple.com/"
#define kGetAppsPath    @"/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=10/json"

@interface ViewController () <UITableViewDataSource>
@property (nonatomic, strong) FeedModel *model;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

#pragma mark - Network

- (void)loadData {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:kGetAppsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.model = [FeedModel mapObjectFromDictionary:[responseObject valueForKey:@"feed"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - <UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)inTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    EntryModel *entry = _model.entry[indexPath.row];
    cell.textLabel.text = entry.name.label;
    
    ImageModel *imgModel = entry.images[0];
    if (imgModel.img){
        cell.imageView.image = imgModel.img;
    } else {
        [imgModel loadImageWithSuccessBlock:^(UIImage *image){
            UITableViewCell *tCell = [inTableView cellForRowAtIndexPath:indexPath];
            tCell.imageView.image = image;
            [inTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)inTableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)inTableView numberOfRowsInSection:(NSInteger)section {
	return _model.entry.count;
}

@end
