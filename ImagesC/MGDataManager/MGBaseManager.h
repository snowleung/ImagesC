//
//  FSBaseManager.h
//  FastSend
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGProtocolBase.h"

@interface MGBaseManager : NSObject <MGProtocolBaseDelegate>

-(void)cleanCache;
@end