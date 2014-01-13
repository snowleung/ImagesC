//
//  MGViewController.h
//  ImagesC
//
//  Created by snow on 7/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"


@interface MGViewController :  UITableViewController <MWPhotoBrowserDelegate,UITableViewDelegate,UITableViewDataSource> {
}
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *catalogs;
@end
