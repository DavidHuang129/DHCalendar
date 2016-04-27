//
//  DHCalendarCollectionViewCell.h
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHCalendarDayModel;
@interface DHCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DHCalendarDayModel *model;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)cellId indexPath:(NSIndexPath*)indexPath;
@end
