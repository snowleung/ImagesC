//
//  MGCatalogProtocol.m
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGCatalogProtocol.h"

@implementation MGCatalogProtocol
@synthesize current_tag, startIndex, length;
-(id)init
{
    self = [super init];
    if (self) {
        self.method = GET;
        current_tag = 1;
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
-(id)initWithTag:(NSInteger)t StartIndex:(NSInteger)start length:(NSInteger)len{
    self = [self init];
    if (self) {
        self.current_tag = t;
        self.startIndex = start;
        self.length = len;
    }
    return self;

}
-(NSString*)getUrl
{
    return [NSString stringWithFormat:@"http://catworld.sinaapp.com/list_catalogs?tag_id=%d&pn=%d&rn=%d",current_tag,startIndex,length];
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
