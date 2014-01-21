//
//  MGTagViewController.h
//  ImagesC
//
//  Created by snow on 21/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGCatalogManager.h"


@interface MGTagViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tags;
@end
