//
//  MGCatalogProtocol.h
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGProtocolBase.h"

@interface MGCatalogProtocol : MGProtocolBase
{
    NSInteger startIndex;
    NSInteger length;
}

@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger length;

-(id)initWithStartIndexAndLength:(NSInteger)start length:(NSInteger)len;

@end
