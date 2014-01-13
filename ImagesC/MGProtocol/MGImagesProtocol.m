//
//  MGImagesProtocol.m
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGImagesProtocol.h"

@implementation MGImagesProtocol
@synthesize startIndex, length,c_id,tag_id;
-(id)init
{
    self = [super init];
    if (self) {
        self.method = GET;
    }
    return self;
}

-(id)initWithStartIndexAndLength:(NSInteger)start length:(NSInteger)len
{
    self = [self init];
    if (self) {
        self.tag_id = 1;
        self.c_id = 1;
        self.startIndex = start;
        self.length = len;
    }
    return self;
}
-(id)initWithTag_id:(NSInteger)tag_id catalog_id:(NSInteger)c_id StartIndex:(NSInteger)start length:(NSInteger)len{
    self = [self init];
    if (self) {
        self.tag_id = tag_id;
        self.c_id = c_id;
        self.startIndex = start;
        self.length = len;
    }
    return self;
}

-(NSString*)getUrl
{
    return [NSString stringWithFormat:@"http://catworld.sinaapp.com/list_images?tag_id=%d&c_id=%d&pn=%d&rn=%d",self.tag_id,self.c_id,startIndex,length];
}

-(void)onAddDataInRoot:(NSMutableString *)rootnode
{
    //由于只是调用了GET方法，所以不用组装post数据
    //    [rootnode appendFormat:@"start_index=%d",1];
    //    [rootnode appendString:@"&"];
    //    [rootnode appendFormat:@"length=%d",20];
}


-(void)onParseJasonData:(NSDictionary *)aData
{
    [super onParseJasonData:aData];
    NSLog(@"%@",aData);
    self.data = aData;
}


@end
