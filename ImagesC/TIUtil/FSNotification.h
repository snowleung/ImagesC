//
//  FSNotification.h
//  FastSend
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//


#ifndef FastSend_FSNotification_h
#define FastSend_FSNotification_h

/*-------------------------------------------------------*
 通知的key
 *-------------------------------------------------------*/
#define kKeyLoginSucc @"kLoginSuccNotification"
#define kKeyLoginFaild @"kLoginFaildNotification"
#define kKeyLBSSucc @"kLBSSuccNotification"
#define kKeyLBSFaild @"kLBSFaildNotification"

#define kKeyAllMartDataSucc @"kAllMartDataSucc"
#define kKeyAllMartDataFaild @"kAllMartDataFaild"

#define kKeyNearMartDataSucc @"kNearMartDataSucc"
#define kKeyNearMartDataFaild @"kNearMartDataFaild"

#define kKeyFirstCatalogDataSucc @"kFirstCatalogDataSucc"
#define kKeyFirstCatalogDataFaild @"kFirstCatalogDataFaild"

#define kKeyDishDataSucc @"kDishDataSucc"
#define kKeyDishDataFaild @"kDishDataFaild"

#define kKeyHistoryDataSucc @"kHistoryDataSucc"
#define kKeyHistoryDataFaild @"kHistoryDataFaild"

#define SEND_NOTIFICATION(NAME,OBJECT) NSNotification *notification =[NSNotification notificationWithName:NAME object:OBJECT]; [[NSNotificationCenter defaultCenter] postNotification:notification];


#endif