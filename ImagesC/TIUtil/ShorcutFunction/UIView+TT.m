//
//  UIView+TT.m
//  fastSend
//
//  Created by Air MacBook on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+TT.h"

@implementation UIView (TT)

-(void)resetX:(CGFloat)nx{
    CGRect frm = self.frame;
    frm.origin.x = nx;
    self.frame  = frm;
}
-(void)resetY:(CGFloat)ny{
    CGRect frm = self.frame;
    frm.origin.y = ny;
    self.frame  = frm;
}
-(void)resetHeight:(CGFloat)nh{
    CGRect frm = self.frame;
    frm.size.height = nh;
    self.frame  = frm;
}
-(void)resetWidth:(CGFloat)nw{
    CGRect frm = self.frame;
    frm.size.width = nw;
    self.frame  = frm;

}
@end
