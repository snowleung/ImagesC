//
//  MGTagsManager.m
//  ImagesC
//
//  Created by snow on 21/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGTagsManager.h"
#import "MGTagsProtocol.h"

@implementation TagsObject
@synthesize tag_name,tag_id;
@end
@implementation TagsModel
@synthesize tags;
-(id)init{
    if (self = [super init]) {
        self.tags = [[NSMutableArray alloc] init];
    }
    return self;
}
@end

@implementation MGTagsManager
@synthesize cModel;

static MGTagsManager *instance = nil;

+(MGTagsManager*)shareTagsManager
{
	@synchronized(self){
		if (instance == nil) {
			instance = [[MGTagsManager alloc] init];
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

-(TagsModel *)listTags:(NSInteger)pn rn:(NSInteger)rn{
    if (!cModel) {
        MGTagsProtocol *p = [[MGTagsProtocol alloc]initWithStartIndexAndLength:pn length:rn];
        p.delegate = self;
        [p startWork];
    }
    return cModel;
}

-(void)hostCallBack:(MGProtocolBase *)protocol withResult:(ProtocolWorkResult)result{
    if (result == ProtocolWorkResult_Success) {
        self.cModel = [self getModelFromData:protocol.data];
        SEND_NOTIFICATION(kKeyListTagsSucc, self.cModel);
    }
}

-(TagsModel *)getModelFromData:(NSDictionary *)data{
    TagsModel *cm = [[TagsModel alloc] init];
    cm.rn = [[data objectForKey:@"rn"] integerValue];
    cm.pn = [[data objectForKey:@"pn"] integerValue];
    cm.total = [[data objectForKey:@"total"] integerValue];
    NSArray *ar = [data objectForKey:@"tags"];
    for (id c in ar) {
        TagsObject *o = [[TagsObject alloc]init];
        o.tag_name = [c objectForKey:@"tag_name"];
        o.tag_id = [[c objectForKey:@"tag_id"] integerValue];
        [cm.tags addObject:o];
    }
    return cm;
}

@end
