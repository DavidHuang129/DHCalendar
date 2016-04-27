//
//  DHCalendarLogic.h
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHCalendarDayModel.h"
/**
 *  日历显示的月数
 */
typedef NS_ENUM(NSInteger, DHCalendarShowType){
    /**
     *  只显示当月
     */
    DHCalendarShowTypeSingle,
    /**
     *  显示多个月数
     */
    DHCalendarShowTypeMultiple
};
@interface DHCalendarLogic : NSObject
@property (nonatomic, strong) NSMutableArray *haveAppointedDays;
@property (nonatomic, strong) DHCalendarOrderInfoModel *orderInfoModel;

- (NSMutableArray *)reloadCalendarView:(NSDate *)date selectDate:(NSDate *)selectDate needDays:(int)days showType:(DHCalendarShowType)type isEnable:(BOOL)isEnable selectDaysArr:(NSMutableArray *)arr;

// 添加可选天数的方法
- (NSMutableArray *)reloadCalendarView:(NSDate *)date selectDate:(NSDate *)selectDate needDays:(int)days showType:(DHCalendarShowType)type isEnable:(BOOL)isEnable selectDaysArr:(NSMutableArray *)arr optionDays:(int)optionDays;
- (NSDateComponents *)dateComponentsFromString:(NSString *)dateString;


@end
