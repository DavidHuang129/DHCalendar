//
//  DHCalendarCollectionViewCell.m
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import "DHCalendarCollectionViewCell.h"
#import "DHCalendarDayModel.h"
#import "NSDate+WQCalendarLogic.h"
#import "UIView+CustomFrame.h"
#import "UIImage+DHCalendar.h"
#import "DHCalendarOrderInfoModel.h"
#define kFont(x) [UIFont systemFontOfSize:x]
#define COLOR_HIGHLIGHT ([UIColor redColor])
#define COLOR_NOAML ([UIColor colorWithRed:0.0f/255.0f green:151.0f/255.0f blue:221/255.0f alpha:1.0f])

#define CellBoundsWidth  self.bounds.size.width
#define CellBoundsHeight  self.bounds.size.height
#define ColorSelectBlue [UIColor colorWithRed:0.0f/255.0f green:151.0f/255.0f blue:221/255.0f alpha:1.0f]  //选中后的蓝色

@interface DHCalendarCollectionViewCell()

/**
 *  显示农历
 */
@property (nonatomic, weak) UILabel *chineseCalendar;


/**
 *  预约票价   此处可根据项目需求自行修改
 */
@property (nonatomic, weak) UILabel *priceLabel;
/**
 *  显示日期
 */
@property (nonatomic, weak) UILabel *dayLabel;

/**
 *  预约时间 或者 预约状态;
 */
@property (nonatomic, weak) UILabel *appointLabel;

@end

@implementation DHCalendarCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)cellId indexPath:(NSIndexPath*)indexPath {
    DHCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    
#warning 价格Label 可根据需求修改
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, CellBoundsHeight * 0.2)];
    priceLabel.textColor = ColorSelectBlue;
    priceLabel.font = [UIFont systemFontOfSize:10];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;

    //日期 label , 可选日期是改变 button 状态并赋值
    
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLabel.frame), CellBoundsWidth* 0.4, CellBoundsWidth* 0.4)];

//    dayButton.backgroundColor = [UIColor greenColor];
    dayLabel.center = CGPointMake(CellBoundsWidth / 2, CGRectGetMaxY(priceLabel.frame) + CGRectGetHeight(dayLabel.frame) / 2);
    dayLabel.layer.cornerRadius = CellBoundsWidth* 0.4 / 2;
    dayLabel.clipsToBounds = YES;
    dayLabel.font = [UIFont systemFontOfSize:14];
    dayLabel.textColor = [UIColor lightGrayColor];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.userInteractionEnabled = YES;
    [self addSubview:dayLabel];
    self.dayLabel = dayLabel;
    
//    //农历
//    UILabel *chineseCalendar = [[UILabel alloc] init];
//    chineseCalendar.font = kFont(12);
//    self.chineseCalendar = chineseCalendar;
//    [self addSubview:chineseCalendar];
    
    UILabel *appointLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dayLabel.frame), self.bounds.size.width, CellBoundsHeight - (CGRectGetMaxY(dayLabel.frame) + 3))];
    appointLabel.textAlignment = NSTextAlignmentCenter;
    appointLabel.textColor = ColorSelectBlue;
    appointLabel.numberOfLines = 2;
    appointLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:appointLabel];
    self.appointLabel = appointLabel;
}

- (void)setModel:(DHCalendarDayModel *)model {
    _model = model;
    switch (model.style) {
        case CellDayTypeEmpty:
            self.priceLabel.hidden = YES;
            self.dayLabel.hidden = YES;
            self.appointLabel.hidden = YES;
            self.backgroundColor = [UIColor whiteColor];
            break;
        case CellDayTypePast:{
            self.dayLabel.hidden = NO;
            NSString *pastDay =  [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            self.dayLabel.text = pastDay;
            self.dayLabel.textColor = [UIColor lightGrayColor];
            
        }
            
            break;
        case CellDayTypeOption:{
            self.dayLabel.hidden = NO;
            self.priceLabel.hidden = NO;
            self.appointLabel.hidden = NO;
            NSString *optionDay =  [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            self.dayLabel.text = optionDay;
            self.dayLabel.textColor = [UIColor whiteColor];
            
        }
            break;
        case CellDayTypeFutur:{
            self.dayLabel.hidden = NO;
            NSString *futureDay =  [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            self.dayLabel.text = futureDay;
            self.dayLabel.textColor = [UIColor lightGrayColor];
        }
            break;
        default:
            break;
    }
    
    //可选日期下
    if (model.isEdit) {
        
        if (model.selectType == CollectionViewSelectTypeEmpty) {
            self.priceLabel.text = nil;
            self.dayLabel.backgroundColor = [UIColor whiteColor];
            self.dayLabel.textColor = [UIColor lightGrayColor];
            self.appointLabel.text = nil;
        }else if(model.selectType == CollectionViewSelectTypeOption){
        
            //背景图片
            self.dayLabel.backgroundColor = ColorSelectBlue;
            self.dayLabel.textColor = [UIColor whiteColor];
            
        }else if(model.selectType == CollectionViewSelectTypeAppoint){
             //预约价格
            self.priceLabel.textColor = ColorSelectBlue;
            self.priceLabel.text = model.orderModel.price;
            
            //背景图片
            self.dayLabel.backgroundColor = ColorSelectBlue;
            self.dayLabel.textColor = [UIColor whiteColor];
            
            //开始时间结束时间
            self.appointLabel.textColor = ColorSelectBlue;
            self.appointLabel.text = [NSString stringWithFormat:@"%@\n%@",model.orderModel.startTime,model.orderModel.endTime];
        }
    }else {
        self.priceLabel.text = nil;
        self.dayLabel.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor lightGrayColor];
        self.appointLabel.text = nil;
    }
    
    //赋值
    if(model.style == CellDayTypePast && [self todayIsEqualTo:model]){
        self.appointLabel.hidden = NO;
        self.appointLabel.text = @"今天";
    }else {
        self.appointLabel.text = @"";
    }
    
}

- (BOOL)todayIsEqualTo:(DHCalendarDayModel *)day {
    NSDate *today = [NSDate date];
    NSDateComponents *calendarToDay  = [today YMDComponents];;
    BOOL isEqual = (calendarToDay.year == day.year) && (calendarToDay.month == day.month) && (calendarToDay.day == day.day);
    return isEqual;
}
@end