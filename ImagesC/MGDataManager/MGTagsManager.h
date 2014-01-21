//
//  MGTagsManager.h
//  ImagesC
//
//  Created by snow on 21/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGBaseManager.h"
@class MGBaseModelObject;

@interface TagsObject : NSObject
{
    NSInteger tag_id;
    NSString *tag_name;
}

@property (nonatomic,copy) NSString *tag_name;
@property (nonatomic,assign) NSInteger tag_id;
@end


@interface  TagsModel : MGBaseModelObject
{
    NSMutableArray *tags;
}

@property (nonatomic, retain) NSMutableArray *tags;
@end


@interface MGTagsManager : MGBaseManager
@property (nonatomic, strong) TagsModel *cModel;
+(MGTagsManager *)shareTagsManager;
-(TagsModel *)listTags:(NSInteger)pn rn:(NSInteger) rn;

@end
