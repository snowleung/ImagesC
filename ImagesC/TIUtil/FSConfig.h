//
//  FSConfig.h
//  FastSend
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#ifndef FastSend_FSConfig_h
#define FastSend_FSConfig_h

#define FSDOMAIN @"http://www.kuaisong.mobi:8000/"
#define FSMEDIA(PICURL) [NSString stringWithFormat:@"http://42.121.17.139:8000/site_media/%@",PICURL]
#define KSMEDIA_THUMB(PICURL) [NSString stringWithFormat:@"http://42.121.17.139:8000/site_media/%@?width=120",PICURL]

#define HEAD_RED_COLOR [UIColor colorWithRed:0.859375f green:0.11328f blue:0.10156f alpha:1.0f]
#define CELL_GREY_COLOR [UIColor colorWithRed:0.95312f green:0.95312f blue:0.95312f alpha:1.0f]
#define CONTENT_LETTER_COLOR [UIColor colorWithRed:0.39844f green:0.39844f blue:0.39844f alpha:1.0f]
#define CONTENT_BLUE_COLOR [UIColor colorWithRed:0.4883f green:0.5586f blue:0.6523f alpha:1.0f]
#define CONTENT_BLUE_COLOR2 [UIColor colorWithRed:0.6406f green:0.7148f blue:0.8359f alpha:1.0f]
#define RED_LETTER_COLOR [UIColor colorWithRed:0.6875f green:0.2148f blue:0.2344f alpha:1.0f]
#define LIGHT_GREY_COLOR [UIColor colorWithRed:0.59857f green:0.59857f blue:0.59857f alpha:1.0f]
#define GREY_COLOR [UIColor colorWithRed:0.6289f green:0.6289f blue:0.6289f alpha:1.0f]
#define DARK_GREY_COLOR [UIColor colorWithRed:0.7314f green:0.7314f blue:0.7314f alpha:1.0f]

#define BACKGROUNDCOLOR [UIColor colorWithRed:231/255.0f green:231/255.0f blue:230/255.0f alpha:1] //通用的视图背景色

#define FSFont(x) [UIFont systemFontOfSize:x]
#define FSCellColor [UIColor colorWithRed:116 green:129 blue:139] //通用的视图背景色
#endif




#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif


static BOOL OSVersionIsAtLeastiOS7() {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}