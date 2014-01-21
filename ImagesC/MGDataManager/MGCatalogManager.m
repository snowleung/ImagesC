//
//  MGCatalogManager.m
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGCatalogManager.h"
#import "MGCatalogProtocol.h"


@implementation catalogsObject
@synthesize c_id;
@synthesize tag_id;
@synthesize title;
@end

@implementation catalogsModel
@synthesize catalogs;
-(id)init{
    if (self = [super init]) {
        self.catalogs = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc{
    [self.catalogs release];
    [super dealloc];
}
@end

@implementation MGCatalogManager
@synthesize cModel;

static MGCatalogManager *instance = nil;

+(MGCatalogManager*)shareCatalogManager
{
	@synchronized(self){
		if (instance == nil) {
			instance = [[MGCatalogManager alloc] init];
		}
	}
	return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

-(void)cleanCache{
    [self.cModel release];
}

-(catalogsModel *)listCatalogs:(NSInteger)pn rn:(NSInteger)rn{
    if (!cModel) {
        MGCatalogProtocol *p = [[MGCatalogProtocol alloc]initWithStartIndexAndLength:pn length:rn];
        p.delegate = self;
        [p startWork];
    }
    return cModel;
}

-(catalogsModel *)listCatalogsWithTag:(NSInteger)t pn:(NSInteger)pn rn:(NSInteger)rn{
    MGCatalogProtocol *p = [[MGCatalogProtocol alloc]initWithTag:t StartIndex:pn length:rn];
    p.delegate = self;
    [p startWork];
    return cModel;
}


-(void)hostCallBack:(MGProtocolBase *)protocol withResult:(ProtocolWorkResult)result{
    if (result == ProtocolWorkResult_Success) {
        self.cModel = [self getModelFromData:protocol.data];
        SEND_NOTIFICATION(kKeyListCatalogsSucc, self.cModel);
    }
}

-(catalogsModel *)getModelFromData:(NSDictionary *)data{
    catalogsModel *cm = [[catalogsModel alloc] init];
    cm.rn = [[data objectForKey:@"rn"] integerValue];
    cm.pn = [[data objectForKey:@"pn"] integerValue];
    cm.total = [[data objectForKey:@"total"] integerValue];
    cm.c_id = [[data objectForKey:@"c_id"] integerValue];
    cm.tag_id = [[data objectForKey:@"tag_id"] integerValue];
    
    NSArray *ar = [data objectForKey:@"catalogs"];
    for (id c in ar) {
        catalogsObject *o = [[catalogsObject alloc]init];
        o.title = [c objectForKey:@"title"];
        o.tag_id = [[c objectForKey:@"tag_id"] integerValue];
        o.c_id = [[c objectForKey:@"id"] integerValue];
        [cm.catalogs addObject:o];
    }
    return cm;
    
}

@end
