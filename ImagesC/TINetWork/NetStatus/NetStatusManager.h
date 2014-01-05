//
//  NetStateManager.h
//  QQMusic
//
//  Created by jordenwu-Mac on 10-10-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//  网络状态管理者

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol NetStatusManagerProtocol

-(void)netReachabilityByWifiChanged:(BOOL)bReachability;

@end


@interface NetStatusManager : NSObject 
{		
	Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
	
	id<NetStatusManagerProtocol> protocol;
}
@property(nonatomic,assign)id<NetStatusManagerProtocol> protocol;

+(NetStatusManager *)sharedNetStatusManager;

-(void)checkAndReport;

-(void)startManager;
//本地wifi是否可用
//-(BOOL)IsEnableWIFI;
//是否能够上网
-(BOOL)IsEnableInternet;
//是否能通过wifi上网
-(BOOL)IsEnableInternetWithLocalWifi;
//是否能通过3G上网
-(BOOL)IsEnableInternetWith3G;

@end
