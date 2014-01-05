//
//  FSUserHelper.h
//  FastSend
//
//  Created by again on 11/13/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSUserHelper : NSObject

+(FSUserHelper*)sharedUserHelper;
+(NSString *)getUserSessionID;
@end
