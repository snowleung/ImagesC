//
//  UIColor+TT.m
//  FastSend
//
//  Created by snow on 12-11-25.
//  Copyright (c) 2012年 again. All rights reserved.
//

#import "UIColor+TT.h"

@implementation UIColor (TT)

+(UIColor*)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
}


@end
