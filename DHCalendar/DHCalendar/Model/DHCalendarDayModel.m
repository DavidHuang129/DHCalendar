//
//  DHCalendarDayModel.m
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import "DHCalendarDayModel.h"

@implementation DHCalendarDayModel

+ (instancetype)calendarWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day{
    return [[self alloc]initWithYear:year month:month day:day];
}
- (instancetype)initWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    if (self = [super init]) {
        self.year = year;
        self.month = month;
        self.day = day;
        self.orderModel = [[DHCalendarOrderInfoModel alloc]init];
        self.selectType = CollectionViewSelectTypeEmpty;
    }
    return self;
}

//返回当前天的NSDate对象
- (NSDate *)date
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.year = self.year;
    c.month = self.month;
    c.day = self.day;
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

//返回当前天的NSString对象
- (NSString *)toString
{
    NSDate *date = [self date];
    NSString *string = [date stringFromDate:date];
    return string;
}


//返回星期
- (NSString *)getWeek
{
    
    NSDate *date = [self date];
    
    NSString *week_str = [date compareIfTodayWithDate];
    
    return week_str;
}

//判断是不是同一天
- (BOOL)isEqualTo:(DHCalendarDayModel *)day
{
    BOOL isEqual = (self.year == day.year) && (self.month == day.month) && (self.day == day.day);
    return isEqual;
}
@end
