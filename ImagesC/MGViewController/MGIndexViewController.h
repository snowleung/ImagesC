//
//  MGIndexViewController.h
//  ImagesC
//
//  Created by snow on 7/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@class MGImagesModel;



@interface MGIndexViewController : MWPhotoBrowser <MWPhotoBrowserDelegate,PSTCollectionViewDelegate> {

}
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
//query data params

@property (nonatomic, assign) NSInteger tag_id;
@property (nonatomic, assign) NSInteger c_id;
@property (nonatomic, assign) NSInteger rn;
@property (nonatomic, assign) NSInteger pn;

-(void)imagesDataRecieve:(NSNotification *)notification;
-(void)reloadSourceWithTag_id:(NSInteger)tag_id catalog_id:(NSInteger)c_id rn:(NSInteger)rn pn:(NSInteger)pn;
-(void)generatePhotos:(MGImagesModel*)m;
@end
