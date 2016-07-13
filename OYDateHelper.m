//
//  OYDateHelper.m
//  lunarCompute
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 ohyeah. All rights reserved.
//
/*
 支持的日期范围
 公历1950年1月1日到2099年12月30日
 农历1950年2月17日到2100年2月8日
*/


#import "OYDateHelper.h"
#define  totalYears 150




@implementation OYDateHelper
UInt32  yearData[totalYears]={
    0x06CA51,0x0B5546,0x555ABB,0x04DA4E,0x0A5B43,0x352BB8,0x052B4C,0x8A953F,0x0E9552,0x06AA48,/*1950-1959*/
    0x6AD53C, 0x0AB54F,0x04B645,0x4A5739,0x0A574D,0x052642,0x3E9335,0x0D9549,0x75AABE,0x056A51,
    0x096D46,0x54AEBB,0x04AD4F,0x0A4D43,0x4D26B7,0x0D254B,0x8D52BF,0x0B5452,0x0B6A47,0x696D3C,
    0x095B50,0x049B45,0x4A4BB9,0x0A4B4D,0xAB25C2,0x06A554,0x06D449,0x6ADA3D,0x0AB651,0x093746,
    0x5497BB, 0x04974F,0x064B44,0x36A537,0x0EA54A,0x86B2BF,0x05AC53,0x0AB647,0x5936BC,0x092E50,
    0x0C9645,0x4D4AB8,0x0D4A4C,0x0DA541,0x25AAB6,0x056A49,0x7AADBD,0x025D52,0x092D47,0x5C95BA,
    0x0A954E,0x0B4A43,0x4B5537,0x0AD54A,0x955ABF,0x04BA53,0x0A5B48,0x652BBC,0x052B50,0x0A9345,
    0x474AB9, 0x06AA4C,0x0AD541,0x24DAB6,0x04B64A,0x69573D,0x0A4E51,0x0D2646,0x5E933A,0x0D534D,
    0x05AA43, 0x36B537,0x096D4B,0xB4AEBF,0x04AD53,0x0A4D48,0x6D25BC,0x0D254F,0x0D5244,0x5DAA38,
    0x0B5A4C,0x056D41,0x24ADB6,0x049B4A,0x7A4BBE,0x0A4B51,0x0AA546,0x5B52BA,0x06D24E,0x0ADA42,
    0x355B37, 0x09374B,0x8497C1,0x049753,0x064B48,0x66A53C,0x0EA54F,0x06B244,0x4AB638,0x0AAE4C,
    0x092E42,0x3C9735,0x0C9649,0x7D4ABD,0x0D4A51,0x0DA545,0x55AABA,0x056A4E,0x0A6D43,0x452EB7,
    0x052D4B, 0x8A95BF,0x0A9553,0x0B4A47,0x6B553B,0x0AD54F,0x055A45,0x4A5D38,0x0A5B4C,0x052B42,
    0x3A93B6,0x069349,0x7729BD,0x06AA51,0x0AD546,0x54DABA,0x04B64E,0x0A5743,0x452738,0x0D264A,
    0x8E933E,0x0D5252,0x0DAA47,0x66B53B,0x056D4F,0x04AE45,0x4A4EB9,0x0A4D4C,0x0D1541,0x2D92B5
};


unsigned char runYueOfEveryYear[totalYears];
unsigned char dayInEveryMonthInEveryYear[totalYears][13];

/**
 *  判断公历年是否为闰年
 *  @param year 公历年年份
 *  @return 是否为公历年
 */
bool isLeapYear(int year);
/**
 *  某农历日期距离农历1950年1月1日的天数
 *  @param year  农历年份
 *  @param month 农历月份
 *  @param day   农历日
 *  @return 总天数
 */
int numberOfdaysToLunarDateSince1950_1_1(int year,int month,int day);
/**
 *  某公历日期距离公历1950年2月17日的天数
 *  @param year  公历年份
 *  @param month 公历月份
 *  @param day   公历日
 *  @return 总天数
 */
int numberOfDaysToNormalDateSince1950_2_17(int year,int month,int day);
/**
 *  返回距离公历1950年2月17日指定天数的公历日期
 *  @param year      公历日期对应的农历日期中的年份
 *  @param totalDays 距离公历1950年2月17日的天数
 *  @return 公历日期
 */
OYDate normalDateSince1950_2_17WithInterval(int year,int totalDays);
/**
 *  返回距离农历1950年1月1日指定天数的农历年份（对应阴阳历的年份）
 *  @param year      农历日期对应的公历日期中的年份
 *  @param totalDays 距离农历1950年1月1日的天数
 *  @return 农历年份
 */
int yearOfLunarDateSince1950_1_1WithInterval(int year,int totalDays);


/**
 *  返回对应某公历日期的农历日期（年份是60年一轮回）
 *  @param year  公历年份
 *  @param month 公历月份
 *  @param day   公历日
 *  @return 农历日期日期
 */
OYDate lunarDateCorrespondingToDate(int year,int month,int day);


/**
 *  判断某公历日期是否无效
 *  日期大于『今日日期』或不是有效的日期返回INVALID；超过支持的日历范围返回OUTOFRANGE，有效日期返回VALID
 */
enum errorCode isLunarDateInvalid(int year,int month,int day);
/**
 *  判断某农历日期是否无效
 *  日期大于『今日日期』或不是有效的日期返回INVALID；超过支持的日历范围返回OUTOFRANGE，有效日期返回VALID
 */
enum errorCode isNormalDateInvalid(int year,int month,int day);

/**
 *  将农历（阴阳历）日期转换成公历日期
 *  @param lunarDate 农历日期
 *  @return 公历日期
 */
-(OYDate)convertLunarDateToNormalDate:(OYDate)lunarDate{
  return  normalDateSince1950_2_17WithInterval(lunarDate.year, numberOfdaysToLunarDateSince1950_1_1(lunarDate.year, lunarDate.month, lunarDate.day));
}

/**
 *  将公历日期转换成农历（阴阳历）日期
 *  @param normalDate 公历日期
 *  @return 农历日期
 */
-(OYDate)convertNormalDateToLunarDate:(OYDate)normalDate{
    OYDate lunarDate=lunarDateCorrespondingToDate(normalDate.year, normalDate.month, normalDate.day);
    int year=yearOfLunarDateSince1950_1_1WithInterval(normalDate.year, numberOfDaysToNormalDateSince1950_2_17(normalDate.year,normalDate.month , normalDate.day));
    OYDate date={year,lunarDate.month,lunarDate.day,true};
    return date;
}
/**
 *  验证公历日期是否无效，返回错误码，非零时无效，为零时有效
 *  @param date 公历日期
 *  @return 错误码 
 *  @discussion 日期大于『今日日期』或不是有效的日期返回INVALID；超过支持的日历范围返回OUTOFRANGE；有效日期返回VALID
 */
-(enum errorCode)isNormalDateInvalid:(OYDate)date{
    return isNormalDateInvalid(date.year, date.month, date.day);
}
/**
 *  验证公历日期是否无效，返回错误码，非零时无效，为零时有效
 *  @param date 农历日期
 *  @return 错误码
 */
-(enum errorCode)isLunarDateInvalid:(OYDate)date{
    return isLunarDateInvalid(date.year, date.month, date.day);
}

+(instancetype)shareHelper{
    static OYDateHelper *helper=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper=[[OYDateHelper alloc]init];
    });
    return helper;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        [self initHelper];
    }
    return self;
}

bool isLeapYear(int year){
    if (year%100==0&&year%400==0) {
        return true;
    }else if(year%100!=0&&year%4==0){
        return true;
    }else{
        return false;
    }
}

int numberOfdaysToLunarDateSince1950_1_1(int year,int month,int day){
    int sum=0;
    //把每年的天数加起来，从1950年加到1992年，year-1
    for (int y=0;y<year-1950 ; y++) {
        const int runYueOfThisYear=(int)runYueOfEveryYear[y];
        int totalMonth=0;
        if(runYueOfThisYear){//如果是有闰月就加13个月
            totalMonth=13;
        }else{
            totalMonth=12;//如果没闰月就加12个月
        }
        for (int m=0; m<totalMonth; m++) {
            sum+=(29+dayInEveryMonthInEveryYear[y][m]);
        }
    }
    //把93年1月到8月的总天数加起来，一般加到month-1月，包含闰月的话就加到month月
    int runYueOfThisYear=(int)runYueOfEveryYear[year-1950];
    int totalMonth=0;
    if (runYueOfThisYear&&runYueOfThisYear<month) {
        totalMonth=month;//指定月份（9月）前有闰月就加到9月
    }else{
        totalMonth=month-1;//指定月份前没有闰月就加到8月
    }
    for (int m=0; m<totalMonth; m++) {
        sum+=(29+dayInEveryMonthInEveryYear[year-1950][m]);
    }
    //把9月之后的日子也加上，day
    sum+=day;
    //    NSLog(@"%d",sum);
    return sum;

}

int numberOfDaysToNormalDateSince1950_2_17(int year,int month,int day){
    int sum=-47;//公历从1950年2月17日开始算起，减去2月17日之前的天数，共31+16=47天
    for(int y=1950;y<year;y++){//把1950年到year-1年的天数加起来
        if (isLeapYear(y)) {
            sum+=366;//闰年366天
        }else{
            sum+=365;//平年365天
        }
    }
    int numberOfDaysInCommonYear[12]={31,28,31,30,31,30,31,31,30,31,30,31};//把1到month-1月的天数加上
    for (int m=0; m<month-1; m++) {
        sum+=numberOfDaysInCommonYear[m];
    }
    if ((month==2&&day==29)||month>2) {//如果日期在2月29日及以后，需要考虑闰月的问题
        sum+=isLeapYear(year);//如果是闰年就加一天
    }
    sum+=day;
    if (sum<1) {
        sum=1;
    }
    return sum;
}

OYDate normalDateSince1950_2_17WithInterval(int year,int totalDays){
    int sumLunar=totalDays;
    int sumGongLi=-47;//公历从1950年2月17日开始算起，减去2月17日之前的天数，共31+16=47天
    int y=year;//假设公历年份和农历年份一样
    for(int y=1950;y<year;y++){//把1950年到1992年的天数加起来
        if (isLeapYear(y)) {
            sumGongLi+=366;//闰年366天
        }else{
            sumGongLi+=365;//平年365天
        }
    }
    if (sumGongLi+365+isLeapYear(year)<totalDays) {//这种情况说明公历年份超过农历年份
        sumGongLi+=(365+isLeapYear(year));
        y++;
    }
    

    int numberOfDaysInLeapYear[12]={31,29,31,30,31,30,31,31,30,31,30,31};//公历闰年每月天数
    int numberOfDaysInCommonYear[12]={31,28,31,30,31,30,31,31,30,31,30,31};//公历平年每月天数
    int m=0;//月份
    if (isLeapYear(year)) {//找到月份
        while (sumGongLi<sumLunar) {
            sumGongLi+=numberOfDaysInLeapYear[m];
            m++;
        }
    }else{
        while (sumGongLi<sumLunar) {
            sumGongLi+=numberOfDaysInCommonYear[m];
            m++;
        }
    }
    sumGongLi-=numberOfDaysInCommonYear[m-1];
    int d=sumLunar-sumGongLi;//找到日
    NSLog(@"%d年%d月%d日",y,m,d);
    OYDate date={y,m,d,false};
    return date;
}

int yearOfLunarDateSince1950_1_1WithInterval(int year,int totalDays){
    int sum=0;
    
    int yearLunar=year-1;//假设农历年比公历年小一年
    for (int y=1950-1950;y<yearLunar-1950 ; y++) {//把之前每年的天数加起来，从1950年加到yearLunar-1年
        int totalMonth=0;
        if(runYueOfEveryYear[y]){//如果是有闰月就加13个月
            totalMonth=13;
        }else{
            totalMonth=12;//如果没闰月就加12个月
        }
        for (int m=0; m<totalMonth; m++) {
            sum+=(29+dayInEveryMonthInEveryYear[y][m]);
        }
    }
    int daysOfLastYear=0;//计算yearLunar这一年有多少天
    if (runYueOfEveryYear[yearLunar-1950]) {
        for (int m=0; m<13; m++) {
            daysOfLastYear+=(29+dayInEveryMonthInEveryYear[yearLunar-1950][m]);
        }
    }else{
        for (int m=0; m<12; m++) {
            daysOfLastYear+=(29+dayInEveryMonthInEveryYear[yearLunar-1950][m]);
        }
    }
    if (daysOfLastYear+sum<totalDays) {//如果加上yearLunar这一年的天数还比totalDays少，说明农历年和公历年是同一年，否则农历年比公历年小一年
        yearLunar+=1;
    }
    if (totalDays<=1) {
        yearLunar=1950;
    }
    NSLog(@"农历年份：%d",yearLunar);
    return yearLunar;
}

OYDate lunarDateCorrespondingToDate(int year,int month,int day){

    NSDateComponents *component=[[NSDateComponents alloc]init];
    component.year=year;
    component.month=month;
    component.day=day;
    NSCalendar *normalCalendar=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *normalDate=[normalCalendar dateFromComponents:component];
    
    NSCalendar *ChineseCalendar=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    int y=(int)[ChineseCalendar component:NSCalendarUnitYear fromDate:normalDate];
    int m=(int)[ChineseCalendar component:NSCalendarUnitMonth fromDate:normalDate];
    int d=(int)[ChineseCalendar component:NSCalendarUnitDay fromDate:normalDate];
    NSLog(@"%d年%d月%d日",y,m,d);
    OYDate date={y,m,d,true};
    return date;
}

enum errorCode isLunarDateInvalid(int year,int month,int day){
    enum errorCode error=VALID;
    
    NSCalendar *ChineseCalendar=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDate *now=[NSDate date];
    NSInteger monthToday=[ChineseCalendar component:NSCalendarUnitMonth fromDate:now];
    NSInteger dayToday=[ChineseCalendar component:NSCalendarUnitDay fromDate:now];
    
    NSInteger yearToday60=[ChineseCalendar component:NSCalendarUnitYear fromDate:now];//获取今日的年份（60为周期的农历年份）
    NSCalendar *normalCalendar=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger yearTodayNormal=[normalCalendar component:NSCalendarUnitYear fromDate:now];//获取今日的公历年份
    NSInteger yearToday=0;
    if(yearToday60<(yearTodayNormal-1950+27)%60 ){//将今日的农历年份和公历年份（60年为周期）作比较以确定今日的农历年份（阴阳历年份）
        yearToday=yearTodayNormal-1;
    }else{
        yearToday=yearTodayNormal;
    }
    
    long int todaySum=yearToday*10000+monthToday*100+dayToday;
    long int dateSum=year*10000+month*100+day;
    long int earliestDateSum=1950*10000+1*100+1;
    
    //判断是否超过农历日期下限（1950年1月1日），以及上限（当天）
    if (dateSum>todaySum||dateSum<earliestDateSum){
        error=OUTOFRANGE;
        return error;
    }
    //验证有效性
    if (month>0&&month<13&&day>0) {
        if (runYueOfEveryYear[year-1950]&&month>runYueOfEveryYear[year-1950]) {
            if (day>29+dayInEveryMonthInEveryYear[year-1950][month]) {
                error=INVALID;
            }
        }else{
            if(day>29+dayInEveryMonthInEveryYear[year-1950][month-1]){
                error=INVALID;
            }
        }
    }else{
        error=INVALID;
    }
    return error;
}


enum errorCode isNormalDateInvalid(int year,int month,int day){
    enum errorCode error=VALID;
    NSCalendar *calendar=[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now=[NSDate date];
    NSDateComponents *today= [calendar components:NSCalendarUnitCalendar fromDate:now];
    
    if (year>today.year){//判断是否超过公历日期上限，也就是当天日期
        error=OUTOFRANGE;
        return error;
    }else if (year==today.year){
        if (month>today.month) {
            error=OUTOFRANGE;
            return error;
        }else if(month==today.month&&day>today.day){
            error=OUTOFRANGE;
            return error;
        }
    }
    if (year<1950) {//判断是否超过公历日期下限，也就是1950年2月17日
        error=OUTOFRANGE;
        return error;
    }else if(year==1950){
        if (month<2) {
            error=OUTOFRANGE;
            return error;
        }else if(month==2&&day<17){
            error=OUTOFRANGE;
            return error;
        }
    }
    //验证有效性
    NSDateComponents *component=[[NSDateComponents alloc]init];
    component.year=year;
    component.month=month;
    component.day=day;
    if ( [component isValidDateInCalendar:calendar]) {
        error=VALID;
    }else{
        error=INVALID;
    }
    return error;
}

-(void)initHelper{
    //提取每年的闰月
    for (int i=0; i<totalYears; i++) {
        runYueOfEveryYear[i]=yearData[i]>>20;
        NSLog(@"%d",runYueOfEveryYear[i]);
    }
    
    //提取每年每月的是否为大月（30天）
    for (int y=0; y<totalYears; y++) {
        int data=yearData[y]>>7;
        for (int m=12; m>=0; m--) {
            if (data==(data>>1)<<1) {
                dayInEveryMonthInEveryYear[y][m]=0;
            }else{
                dayInEveryMonthInEveryYear[y][m]=1;
            }
            data=data>>1;
        }
    }

}


@end
