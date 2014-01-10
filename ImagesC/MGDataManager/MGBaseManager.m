//
//  MGBaseManager.m
//  FastSend
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#import "MGBaseManager.h"

@implementation MGBaseModelObject

@synthesize rn,pn,total,c_id,tag_id;

@end

@implementation MGBaseManager

-(void)hostCallBack:(MGProtocolBase *)protocol withResult:(ProtocolWorkResult)result
{
    NSLog(@"虚函数调用");
}

-(void)cleanCache
{
    NSLog(@"虚函数调用，刷新数据");
}
@end
