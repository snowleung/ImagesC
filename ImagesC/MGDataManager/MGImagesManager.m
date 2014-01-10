//
//  MGImagesManager.m
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGImagesManager.h"
#import "MGImagesProtocol.h"

@implementation MGImagesObject
@synthesize create_at,description,filename,link,origin_url;
@end

@implementation MGImagesModel
@synthesize images;
-(id)init{
    if (self = [super init]) {
        self.images = [[NSMutableArray alloc] init];
    }
    return self;
}

@end



@implementation MGImagesManager
@synthesize iModel;
static MGImagesManager *instance = nil;

+(MGImagesManager *)shareImagesManager
{
	@synchronized(self){
		if (instance == nil) {
			instance = [[MGImagesManager alloc] init];
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

-(MGImagesModel *)listImages:(NSInteger)tag_id catalog_id:(NSInteger)c_id start_index:(NSInteger)pn rn:(NSInteger) rn{
    if (!iModel) {
        MGImagesProtocol *p = [[MGImagesProtocol alloc] initWithTag_id:tag_id catalog_id:c_id StartIndex:pn length:rn];
        p.delegate = self;
        [p startWork];
    }
    return iModel;

}
//-(MGImagesModel *)listImages:(NSInteger)tag_id catalog_id:(NSInteger)c_id start_index:(NSInteger)pn rn:(NSInteger)rn{
//    if (!iModel) {
//        MGImagesProtocol *p = [[MGImagesProtocol alloc] initWithTag_id:tag_id catalog_id:c_id StartIndex:pn length:rn];
//        p.delegate = self;
//        [p startWork];
//    }
//    return iModel;
//}

-(void)hostCallBack:(MGProtocolBase *)protocol withResult:(ProtocolWorkResult)result{
    if (result == ProtocolWorkResult_Success) {
        self.iModel = [self getModelFromData:protocol.data];
        SEND_NOTIFICATION(kKeyListImagesSucc, self.iModel);
    }
}

-(MGImagesModel *)getModelFromData:(NSDictionary *)data{
    MGImagesModel *cm = [[MGImagesModel alloc] init];
    cm.rn = [[data objectForKey:@"rn"] integerValue];
    cm.pn = [[data objectForKey:@"pn"] integerValue];
    cm.total = [[data objectForKey:@"total"] integerValue];
    
    NSArray *ar = [data objectForKey:@"images"];
    for (id c in ar) {
        MGImagesObject *o = [[MGImagesObject alloc]init];
        
        o.description = [c objectForKey:@"description"];
        o.origin_url = [c objectForKey:@"origin_url"];
        o.create_at = [c objectForKey:@"create_at"];
        o.filename = [c objectForKey:@"filename"];
        o.link = [c objectForKey:@"link"];

        [cm.images addObject:o];
    }
    return cm;
    
}

@end
