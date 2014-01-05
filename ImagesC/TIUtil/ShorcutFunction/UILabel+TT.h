//
//  UILabel+TT.h
//  fastSend
//
//  Created by Air MacBook on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TT)
-(CGSize)autoLines:(NSInteger)lines Text:(NSString *)txt Font:(UIFont *)l_font ContstrainSize:(CGSize)l_size;
-(CGSize)singleLineAutoSizeText:(NSString*)txt Font:(UIFont*)l_font ContstrainSize:(CGSize)l_size; 
@end
