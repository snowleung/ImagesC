//
//  MGCatalogManager.h
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGBaseManager.h"

@class MGBaseModelObject;


@interface catalogsObject : NSObject
{
    NSInteger c_id;
    NSInteger tag_id;
    NSString *title;
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger c_id;
@property (nonatomic,assign) NSInteger tag_id;
@end


@interface  catalogsModel : MGBaseModelObject
{
    NSMutableArray *catalogs;
}

@property (nonatomic, retain) NSMutableArray *catalogs;
@end


@interface MGCatalogManager : MGBaseManager
@property (nonatomic, retain) catalogsModel *cModel;
+(MGCatalogManager *)shareCatalogManager;
-(catalogsModel *)listCatalogs:(NSInteger)pn rn:(NSInteger) rn;
@end
