//
//  DHCalendarDayModel.h
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#define CAN_SHOW 1    //可以被点击
#define CANNOT_SHOW 0//不能被点击

#import <Foundation/Foundation.h>
#import "NSDate+WQCalendarLogic.h"
#import "DHCalendarOrderInfoModel.h"
#import "DHCalendarDayModel.h"
typedef NS_ENUM(NSInteger, CollectionViewCellDayType) {
    CellDayTypeEmpty,   //不显示
    CellDayTypePast,    //过去的日期
    CellDayTypeOption,  //未来可选日期;
    CellDayTypeFutur,   //将来的日期
};

//展现样式
typedef NS_ENUM(NSInteger, CollectionViewSelectType) {
    CollectionViewSelectTypeEmpty,   //不显示 (白底)
    CollectionViewSelectTypeOption,    //可选择 (蓝底)
    CollectionViewSelectTypeAppoint,  //也编辑预约日期(已发布); (蓝底带时间)
    CollectionViewSelectTypeHaveAppointed, //已预约
};

@interface DHCalendarDayModel : NSObject

@property (nonatomic, assign) CollectionViewCellDayType style;
@property (nonatomic, assign) NSUInteger day;//天
@property (nonatomic, assign) NSUInteger month;//月
@property (nonatomic, assign) NSUInteger year;//年
@property (nonatomic, assign) NSUInteger week;//周
@property (nonatomic, assign) CollectionViewSelectType selectType;

@property (nonatomic, strong) NSString *Chinese_calendar;//农历
@property (nonatomic, strong) NSString *holiday;//节日

@property (nonatomic, assign)  BOOL    isEdit;
//- (BOOL)isEqualTo:(CalendarDayModel *)day;//判断是不是同一天
//预约信息
@property (nonatomic, strong) DHCalendarOrderInfoModel *orderModel;

+ (instancetype)calendarWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (instancetype)initWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSDate *)date;//返回当前天的NSDate对象
- (NSString *)toString;//返回当前天的NSString对象
- (NSString *)getWeek; //返回星期

@end
