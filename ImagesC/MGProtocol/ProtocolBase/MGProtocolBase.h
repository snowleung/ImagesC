//
//  MGProtocolBase.h
//  FastSend
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

#define SAFE_RELEASE_PROTOCOL(x) if(x){x.delegate = nil; [x release]; x = nil;}

typedef enum _HTTPMETHOD {
    POST = 0,
    GET,
}METHOD;

@protocol MGProtocolBaseDelegate;

@interface MGProtocolBase : NSObject <ASIHTTPRequestDelegate>
{
    id<MGProtocolBaseDelegate> delegate;
    NSData * postData;
    NSMutableData *recieveData;
    int retState;
    id key;  //获取数据的钥匙
    id data; //最终交付的数据
    METHOD method;
}

@property (nonatomic,assign)id<MGProtocolBaseDelegate> delegate;
@property (nonatomic,retain) NSData *postData;
@property (nonatomic,retain) NSMutableData *recieveData;
@property (nonatomic,assign) int retState;
@property (nonatomic,assign) id key;
@property (nonatomic,retain) id data;
@property (nonatomic,assign) METHOD method;
-(id)initWithKey:key_;
-(void)startWork;
-(void)onParseJasonData:(NSDictionary *)aData;

@end

@protocol MGProtocolBaseDelegate <NSObject>

@required
-(void)hostCallBack:(MGProtocolBase *)protocol withResult:(ProtocolWorkResult)result;
@optional

@end

