//
//  UILabel+TT.m
//  fastSend
//
//  Created by Air MacBook on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILabel+TT.h"
#import "UIView+TT.h"
@implementation UILabel (TT)
-(CGSize)autoLines:(NSInteger)lines Text:(NSString *)txt Font:(UIFont *)l_font ContstrainSize:(CGSize)l_size{
    self.numberOfLines = lines;
    self.font = l_font;
    self.text = txt;
    CGSize dynamicSize = [txt sizeWithFont:l_font constrainedToSize:l_size lineBreakMode:UILineBreakModeWordWrap];
    
    [self resetHeight:dynamicSize.height];
    [self resetWidth:dynamicSize.width];
    
    return dynamicSize;
    
}
-(CGSize)singleLineAutoSizeText:(NSString *)txt Font:(UIFont *)l_font ContstrainSize:(CGSize)l_size{
    return [self autoLines:1 Text:txt Font:l_font ContstrainSize:l_size];
}






@end
