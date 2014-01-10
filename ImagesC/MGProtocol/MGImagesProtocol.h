//
//  MGImagesProtocol.h
//  ImagesC
//
//  Created by snow on 10/1/14.
//  Copyright (c) 2014 snow. All rights reserved.
//

#import "MGProtocolBase.h"

@interface MGImagesProtocol : MGProtocolBase
{
    NSInteger tag_id;
    NSInteger c_id;
    NSInteger startIndex;
    NSInteger length;
}

@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign) NSInteger tag_id;
@property (nonatomic, assign) NSInteger c_id;

-(id)initWithStartIndexAndLength:(NSInteger)start length:(NSInteger)len;
-(id)initWithTag_id:(NSInteger)tag_id catalog_id:(NSInteger)c_id StartIndex:(NSInteger)start length:(NSInteger)len;
@end
