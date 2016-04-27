//
//  ViewController.m
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import "ViewController.h"
#import "DHCalendarController.h"
#import "DHCalendarDayModel.h"
#import "DHCalendarOrderInfoModel.h"
#import "MJExtension.h"
//屏幕的高度
#define boundsHeight [[UIScreen mainScreen] bounds].size.height
//屏幕的宽度
#define boundsWidth [[UIScreen mainScreen] bounds].size.width
//导航条高度
#define navigationBarHeight 64
@interface ViewController ()<DHCalendarControllerDelegate>
@property (nonatomic, strong)     DHCalendarController *calendarVC;
@property (nonatomic, strong) DHCalendarOrderInfoModel *orderInfoModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testUI];
    
    //
    [self test30DaysSinceToday];
}


- (void)dh_CalendarControllerDidCollectionViewItemClickWithCalendarDayModel:(DHCalendarDayModel *)dayModel {
    
    NSLog(@"%@-%@-%@ \n",@(dayModel.year),@(dayModel.month),@(dayModel.day));
}
- (void)test30DaysSinceToday {
    [_calendarVC updateWithOptionDays:15];
}
- (void)testUI {

    _calendarVC = [[DHCalendarController alloc]initWithDays:60 optionDays:0 showType:DHCalendarShowTypeMultiple];
    [self addChildViewController:_calendarVC];
    _calendarVC.view.frame = CGRectMake(0, navigationBarHeight + 40, boundsWidth, boundsHeight-navigationBarHeight - 40);
    [self.view addSubview:_calendarVC.view];
    _calendarVC.isEnable = YES;
    _calendarVC.delegate = self;

    [self.navigationController pushViewController:_calendarVC animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
