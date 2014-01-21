//
//  MGTagsProtocol.m
//  ImagesC
//
//  Created by snow on 21/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGTagsProtocol.h"

@implementation MGTagsProtocol
@synthesize startIndex, length;
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
        self.startIndex = start;
        self.length = len;
    }
    return self;
}

-(NSString*)getUrl
{
    return [NSString stringWithFormat:@"http://catworld.sinaapp.com/list_tags?pn=%d&rn=%d",startIndex,length];
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
