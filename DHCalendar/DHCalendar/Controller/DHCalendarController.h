//
//  DHCalendarController.h
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DHCalendarLogic.h"

@protocol DHCalendarControllerDelegate;
typedef void (^DHCalendarBlock)(DHCalendarDayModel *dayModel);

@interface DHCalendarController : UIViewController
@property (nonatomic, weak) id<DHCalendarControllerDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGRect   selfViewFrame;


//每个月份中的 dayModel容器
@property (nonatomic, strong) NSMutableArray   *calendarMonthArr;
//月历排布模型
@property (nonatomic, strong) DHCalendarLogic *calendarLogic;

@property (nonatomic, copy) DHCalendarBlock calendarBlock;
//月历天数
@property (nonatomic, assign)  int allCalendarDays;
//可选用的日历时间
@property (nonatomic, assign)  int optionDays;

//月历展示类型
@property (nonatomic, assign)  DHCalendarShowType showtype;
//预约信息选中日期数组
@property (nonatomic, strong)  NSMutableArray *selectDaysArr;
@property (nonatomic, assign)  BOOL  isEnable;


- (instancetype)initWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType;
- (instancetype)initWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType selectDaysArr:(NSMutableArray *)selectDaysArr;

+ (instancetype)DHCalendarWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType;
+ (instancetype)DHCalendarWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType selectDaysArr:(NSMutableArray *)selectDaysArr;

- (void)updateWithOptionDays:(int)optionDays;

@end


@protocol DHCalendarControllerDelegate <NSObject>

@optional
- (void)dh_CalendarControllerDidCollectionViewItemClickWithCalendarDayModel:(DHCalendarDayModel *)dayModel;
@end
