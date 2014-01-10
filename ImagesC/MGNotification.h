//
//  MGNotification.h
//  ImagesC
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//


#ifndef ImagesC_MGNotification_h
#define ImagesC_MGNotification_h

/*-------------------------------------------------------*
 通知的key
 *-------------------------------------------------------*/
#define kKeyListCatalogsSucc @"kKeyListCatalogsSucc"

#define SEND_NOTIFICATION(NAME,OBJECT) NSNotification *notification =[NSNotification notificationWithName:NAME object:OBJECT]; [[NSNotificationCenter defaultCenter] postNotification:notification];


#endif