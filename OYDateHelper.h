//
//  OYDateHelper.h
//  lunarCompute
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 ohyeah. All rights reserved.
//

#import <Foundation/Foundation.h>

enum errorCode{
    VALID =0,//有效
    OUTOFRANGE=1,//超出范围
    INVALID=2//无效
};
typedef struct date{
    int year;
    int month;
    int day;
    bool isLunar;
} OYDate;

@interface OYDateHelper : NSObject
-(OYDate)convertLunarDateToNormalDate:(OYDate)lunarDate;
-(OYDate)convertNormalDateToLunarDate:(OYDate)normalDate;
-(enum errorCode)isLunarDateInvalid:(OYDate)date;
-(enum errorCode)isNormalDateInvalid:(OYDate)date;
+(instancetype)shareHelper;
@end
