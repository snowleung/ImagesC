//
//  MGBasic.h
//  ImagesC
//
//  Created by again on 11/6/12.
//  Copyright (c) 2012 again. All rights reserved.
//

#ifndef ImagesC_MGBasic_h
#define ImagesC_MGBasic_h

typedef enum
{
	ProtocolWorkResult_Success = 0,//成功
	ProtocolWorkResult_ParseException,//解析异常
	ProtocolWorkResult_NetError,//网络不可用
	ProtocolWorkResult_UIDSIDError,//UIDSID引发错误
	ProtocolWorkResult_IPLimitError,//ip引发错误
	ProtocolWorkResult_Failed, //莫明失败
    ProtocolWorkResult_Loginfailed
}ProtocolWorkResult;

#define SAFE_RELEASE(x) if(x){x.delegate = nil; [x release]; x = nil;}

#define AppHeght [[UIScreen mainScreen] applicationFrame].size.height
#define TabbarHeight 49.0f
#define NavBarHeight 46.0f

//view tag
//全屏幕正在加载提示信息
#define LOADING_TAG             300
#define LOADING_INFO_TAG		301
#define LOADING_INDICATOR_TAG	302
#endif
