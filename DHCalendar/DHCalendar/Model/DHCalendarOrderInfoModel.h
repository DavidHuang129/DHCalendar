//
//  DHCalendarOrderInfoModel.h
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHCalendarOrderInfoModel : NSObject

/**
 *  预约费用
 */
@property (nonatomic, copy) NSString *price;

/**
 *  预约开始时间
 */
@property (nonatomic, copy) NSString *startTime;
/**
 *  预约结束时间
 */
@property (nonatomic, copy) NSString *endTime;

@end
