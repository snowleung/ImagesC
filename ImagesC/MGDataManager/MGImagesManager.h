//
//  MGImagesManager.h
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGBaseManager.h"

@class MGBaseModelObject;

@interface MGImagesObject : NSObject

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *origin_url;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *link;
@end

@interface MGImagesModel : MGBaseModelObject

@property (nonatomic,retain) NSMutableArray *images;

@end

@interface MGImagesManager : MGBaseManager
@property (nonatomic, retain) MGImagesModel *iModel;
+(MGImagesManager *)shareImagesManager;
-(MGImagesModel *)listImages:(NSInteger)tag_id catalog_id:(NSInteger)c_id start_index:(NSInteger)pn rn:(NSInteger) rn;
@end
