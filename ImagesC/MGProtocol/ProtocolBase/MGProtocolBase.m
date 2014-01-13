//
//  MGProtocolBase.m
//  FastSend
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#import "MGProtocolBase.h"
#import "NetStatusManager.h"
#import "SBJson.h"

@interface MGProtocolBase(Method)
-(void)onAddDataInRootWithKey:(id)key andValue:(id)value;
-(BOOL)parseCompressedData:(NSData *)compressedData;
-(void)onAddDataInRoot:(NSMutableString *)rootnode;
@end

@implementation MGProtocolBase
@synthesize postData;
@synthesize delegate;
@synthesize recieveData;
@synthesize key;
@synthesize retState;
@synthesize data;
@synthesize method;

-(id)initWithKey:key_
{
    if (self=[super init])
	{
		key = key_;
	}
	return self;
}

-(void)dealloc
{
    [postData release];
    [recieveData release];
    [data release];
    [super dealloc];
}

-(NSString*)getUrl
{
    return nil;
}

-(NSData *)createPostData
{
	NSLog(@"%@ -- 开始创建Post Data",[self description]);
	
    NSMutableString *postRoot = [[NSMutableString alloc]init];
    //带上普遍的postData
    //以后可以带上一些统计数据
    
    //独立添加特定的上传数据
	[self onAddDataInRoot:postRoot];
	
	NSData *createdXMLData=[postRoot dataUsingEncoding:NSUTF8StringEncoding];
	return createdXMLData;
}

-(void)onAddDataInRoot:(NSMutableString *)rootnode
{
	NSLog(@"ERR:虚函数调用！");
}

-(void)uploadRequestWithURLStr:(NSString *)aURLStr
{
    ASIHTTPRequest *request = nil;
    if (self.method == POST)
    {
        self.postData = [self createPostData];
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:aURLStr]];
        [request appendPostData:self.postData];
        [request addRequestHeader:@"host" value:MGDOMAIN];
        [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
        [request setShouldAttemptPersistentConnection:YES];
        [request setRequestMethod:@"POST"];
    }
    else
    {
        request =  [ASIHTTPRequest requestWithURL:[NSURL URLWithString:aURLStr]];
        [request setRequestMethod:@"GET"];
    }
    [request setDelegate:self];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
}



-(void)onParseJasonData:(NSDictionary *)aData
{
    NSLog(@"解析json");
}

-(BOOL)parseCompressedData:(NSData *)compressedData
{
    NSAutoreleasePool *autoPool = [[NSAutoreleasePool alloc] init];
    if ([compressedData length] < 30) {
        NSString *str = [[NSString alloc]initWithData:compressedData encoding:NSUTF8StringEncoding];
        NSLog(@"%@ -- 错误的回包：(%@)(%@)", [self description],str, compressedData);
        [str release];
    }
    BOOL bParseOK = NO;
    if ([compressedData length] > 5)
    {
        NSString *strReceive ;
        strReceive = [[NSString alloc] initWithData:compressedData encoding:NSUTF8StringEncoding];
        
        if (strReceive && strReceive.length > 10) {
            NSString *shortStr = [[NSMutableString stringWithString:strReceive] substringToIndex:10];
            NSLog(@"%@ -- 返回数据:\n%@\n\n",[self description],shortStr);
        }
        else {
            NSLog(@"%@ -- 返回数据:\n%@\n\n",[self description],strReceive);
        }
        
        if(strReceive != nil && [strReceive length] > 0)
        {
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *dataDictionary = [jsonParser objectWithString:strReceive error:&error];
            if (!error) {
                [self onParseJasonData:dataDictionary];
                bParseOK = YES;
            }
            else {
                NSLog(@"json解析错误: %@", error);
                bParseOK = NO;
            }
            [jsonParser release];
        }
        
        [strReceive release];
    }
    [autoPool drain];
    return bParseOK;
    
}
#pragma ASIHttpRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if ([self parseCompressedData:recieveData]) {
        
        if (delegate && [delegate respondsToSelector:@selector(hostCallBack:withResult:)]) {
            //成功解析数据，返回
              [delegate hostCallBack:self withResult:ProtocolWorkResult_Success];
        }
    }
    else {
        if (delegate && [delegate respondsToSelector:@selector(hostCallBack:withResult:)]) {
            [delegate hostCallBack:self withResult:ProtocolWorkResult_ParseException];
        }
        else
        {
            NSLog(@"------------------------------------------------");
            NSLog(@"注意拉注意啦。。。十万火急，该class未处理网络解析异常。本class:%@",delegate);
            NSLog(@"------------------------------------------------");
        }
    }
    
    request.delegate = self;
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"连接失败，requestFailed。本class:%@",delegate);
    if (delegate && [delegate respondsToSelector:@selector(hostCallBack:withResult:)]) {
        [delegate hostCallBack:self withResult:ProtocolWorkResult_NetError];
    }
    else
    {
        NSLog(@"------------------------------------------------");
        NSLog(@"注意拉注意啦。。。十万火急，该class未处理网络返回有问题。本class:%@",delegate);
        NSLog(@"------------------------------------------------");
    }
    
    request.delegate = nil;
}

-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)_data
{
    if (recieveData == nil) {
        recieveData = [[NSMutableData alloc]init];
    }
    [recieveData appendData:_data];
}

#pragma mark -

-(void)startWork
{
    //首先只要能上网就连接
	if ([[NetStatusManager sharedNetStatusManager]IsEnableInternet])
    {
        [self uploadRequestWithURLStr:[self getUrl]];
    }
    else { // 网络不可用
        if (delegate && [delegate respondsToSelector:@selector(hostCallBack:withResult:)]) {
            [delegate hostCallBack:self withResult:ProtocolWorkResult_NetError];
        }
    }
}


@end

