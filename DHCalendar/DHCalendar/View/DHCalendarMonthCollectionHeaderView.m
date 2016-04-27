
//
//  DHCalendarMonthCollectionHeaderView.m
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import "DHCalendarMonthCollectionHeaderView.h"

#define CATDayLabelWidth  ([UIScreen mainScreen].bounds.size.width/7)
#define CATDayLabelHeight 20.0f

#define COLOR_THEME1 ([UIColor redColor])//大红色
#define COLOR_THEME ([UIColor colorWithRed:0.0f/255.0f green:151.0f/255.0f blue:221/255.0f alpha:1.0f])//蓝

#define VIPTravel_Color_h

@interface DHCalendarMonthCollectionHeaderView ()

@end




@implementation DHCalendarMonthCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initWithHeader];
    }
    return self;
}

- (void)initWithHeader
{
    self.clipsToBounds = YES;
    CGFloat headerWidth = [UIScreen mainScreen].bounds.size.width;
    //月份
    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 10.0f, headerWidth, 30.f)];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.masterLabel = masterLabel;
    self.masterLabel.textColor = COLOR_THEME;
    [self addSubview:self.masterLabel];
    CGFloat yOffset = 45.0f;
    NSArray *textArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < textArray.count; i++) {
        [self initHeaderWeekText:textArray[i] titleColor:COLOR_THEME x:CATDayLabelWidth * i y:yOffset];
    }
    
}

// 初始化数据
- (void)initHeaderWeekText:(NSString *)text titleColor:(UIColor *)color x:(CGFloat)x y:(CGFloat)y {
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(x, y, CATDayLabelWidth, CATDayLabelHeight)];
    [titleText setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.textColor = color;
    titleText.text = text;
    [self addSubview:titleText];
}

@end