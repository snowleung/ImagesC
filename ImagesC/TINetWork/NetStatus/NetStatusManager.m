//
//  NetStateManager.m
//  QQMusic
//
//  Created by jordenwu-Mac on 10-10-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NetStatusManager.h"

@interface NetStatusManager(Method)
-(void)checkAndReport;
@end


@implementation NetStatusManager
static NetStatusManager *instance=nil;
@synthesize protocol;

+(NetStatusManager *)sharedNetStatusManager
{
	@synchronized(self)
	{
		if (instance==nil) 
		{
			instance = [[NetStatusManager alloc]init];
			[instance startManager];
		}
	}
    return instance;	
}
-(id)init
{	
	if (self=[super init]) 
	{
		/*
		hostReach = [[Reachability reachabilityWithHostName: @"www.qq.com"] retain];
		internetReach = [[Reachability reachabilityForInternetConnection] retain];
		wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
		*/
	}
	return self;
}

-(void)startManager
{
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	//Change the host name here to change the server your monitoring
	hostReach = [[Reachability reachabilityWithHostName: @"www.qq.com"] retain];
	//[hostReach startNotifier];
	
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	//[internetReach startNotifier];
	
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[wifiReach startNotifier];
}
// 是否wifi
-(BOOL)IsEnableWIFI
{
	return ([wifiReach currentReachabilityStatus] != NotReachable);
}

//状态改变通知
- (void) reachabilityChanged: (NSNotification* )note
{	
	//[self performSelector:@selector(checkAndReport) withObject:nil afterDelay:0.5];
}

-(void)checkAndReport
{
	if(protocol && [(NSObject*)protocol respondsToSelector:@selector(netReachabilityByWifiChanged:)])
		[protocol netReachabilityByWifiChanged:[self IsEnableInternetWithLocalWifi]];
}

//是否能够连接到Internet
-(BOOL)IsEnableInternet
{   
	if ([internetReach currentReachabilityStatus] != NotReachable) {
		return YES;
	}
	else {
		return NO;
	}
}
//是否能够通过本地WIFI上网
-(BOOL)IsEnableInternetWithLocalWifi
{  
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	if (netStatus!= NotReachable) 
	{
		if(netStatus == ReachableViaWiFi)
		{
			return YES;
		}
		else {
			return NO;
		}

	}
	else {
		return NO;
	}	
}
//是否能够通过3G上网
-(BOOL)IsEnableInternetWith3G
{	
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	if (netStatus!= NotReachable) 
	{
		if(netStatus == ReachableViaWWAN)
		{
			return YES;
		}
		else{
			return NO;
		}
	}
	else {
		return NO;
	}
}
-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[hostReach release];
	[internetReach release];
	[wifiReach release];
	[super dealloc];
}
@end
