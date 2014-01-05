//
//  FSUserHelper.m
//  FastSend
//
//  Created by again on 11/13/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#import "FSUserHelper.h"


@implementation FSUserHelper
static FSUserHelper *instance = nil;
+(FSUserHelper *)sharedUserHelper
{
    @synchronized(self){
		if (instance == nil) {
			instance = [[FSUserHelper alloc] init];
		}
	}
	return instance;
}

+(NSString *)getUserSessionID
{
    return nil;
}

@end
