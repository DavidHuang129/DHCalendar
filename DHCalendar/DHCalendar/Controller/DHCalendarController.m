
//
//  DHCalendarController.m
//  DHCalendar
//
//  Created by DavidHuang on 16/3/29.
//  Copyright © 2016年 DavidHuang. All rights reserved.
//

#import "DHCalendarController.h"
#import "NSDate+WQCalendarLogic.h"

#import "DHCalendarMonthCollectionViewFlowLayout.h"
#import "DHCalendarMonthCollectionHeaderView.h"
#import "DHCalendarCollectionViewCell.h"

#import "DHCalendarDayModel.h"

@interface DHCalendarController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

static NSString *monthHeaderId = @"monthHeaderId";
static NSString *dayCellId = @"dayCellId";
@implementation DHCalendarController


- (DHCalendarLogic *)calendarLogic {
    if(!_calendarLogic) {
        _calendarLogic = [[DHCalendarLogic alloc]init];
    }
    return _calendarLogic;
}
- (void)setSelectDaysArr:(NSMutableArray *)selectDaysArr {
#if __has_feature(objc_arc)
    _selectDaysArr = selectDaysArr;
#else
    if(_selectDaysArr != selectDaysArr) {
        [_selectDaysArr release];
        _selectDaysArr = [selectDaysArr retain];
    }
#endif
}

-(void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
}

//初始化对象
- (instancetype)initWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType {
    if (self = [super init]) {
        self.allCalendarDays = days;
        self.showtype = showType;
        self.optionDays = optionDays;
        self.selfViewFrame = CGRectZero;
        self.selectDaysArr = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType selectDaysArr:(NSMutableArray *)selectDaysArr {
    if (self = [super init]) {
        self.allCalendarDays = days;
        self.showtype = showType;
        self.optionDays = optionDays;
        self.selectDaysArr = selectDaysArr?selectDaysArr:[NSMutableArray array];
        self.selfViewFrame = CGRectZero;
    }
    return self;
}

+ (instancetype)DHCalendarWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType {
    return [[self alloc]initWithDays:days optionDays:optionDays showType:showType];
}
+ (instancetype)DHCalendarWithDays:(int)days optionDays:(int)optionDays showType:(DHCalendarShowType)showType selectDaysArr:(NSMutableArray *)selectDaysArr {
    return [[self alloc]initWithDays:days optionDays:optionDays showType:showType selectDaysArr:selectDaysArr];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.optionDays = 0;
    [self setUpView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!CGRectEqualToRect(_selfViewFrame, CGRectZero)) {
        self.view.frame = _selfViewFrame;
    }
}

- (void)setUpView {
    
    DHCalendarMonthCollectionViewFlowLayout *flowLayout = [[DHCalendarMonthCollectionViewFlowLayout alloc]init];
#if !__has_feature(objc_arc)
    [flowLayout release];
#endif
    //初始化表格视图
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
   
    [self.collectionView registerClass:[DHCalendarCollectionViewCell class] forCellWithReuseIdentifier:dayCellId];
    [self.collectionView registerClass:[DHCalendarMonthCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:monthHeaderId];
    
    //    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
  
     self.calendarMonthArr =  [self getMonthArrayOfDays:self.allCalendarDays showType:DHCalendarShowTypeMultiple isEnable:self.isEnable selectDaysArr:self.selectDaysArr optionDays:self.optionDays];
}
#pragma mark - Private Method
/**
 *  获取Days天数内的数组
 *
 *  @param days       天数
 *  @param type       显示类型
 *  @param isEnable   是否可选,默认是可选的
 *  @param arr        模型数组
 *  @param optionDays 可选的天数
 *
 *  @return 数组
 */
- (NSMutableArray *)getMonthArrayOfDays:(int)days showType:(DHCalendarShowType)type isEnable:(BOOL)isEnable selectDaysArr:(NSMutableArray *)arr optionDays:(int)optionDays {
    NSDate *date = [NSDate date];
    //默认选中天数为7天
    NSDate *selectdate  = [NSDate date];
    //清空已选择的日期模型
    [self.selectDaysArr removeAllObjects];
    
    //返回数据模型数组
    return [self.calendarLogic reloadCalendarView:date selectDate:selectdate needDays:days showType:type isEnable:isEnable selectDaysArr:arr optionDays:optionDays];
}

- (void)updateWithOptionDays:(int)optionDays {
    self.optionDays = optionDays;
    self.isEnable = YES;
    self.calendarMonthArr = [self getMonthArrayOfDays:self.allCalendarDays showType:DHCalendarShowTypeMultiple isEnable:self.isEnable selectDaysArr:self.selectDaysArr optionDays:optionDays];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionDelegate
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.calendarMonthArr.count;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonthArr objectAtIndex:section];
    
    return monthArray.count;
}

//定义展示 ItemCell 内部的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   DHCalendarCollectionViewCell *cell = [DHCalendarCollectionViewCell cellWithCollectionView:collectionView identifier:dayCellId indexPath:indexPath];

        NSMutableArray *monthArray = [self.calendarMonthArr objectAtIndex:indexPath.section];
        DHCalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    if (model.style == CellDayTypeOption) {
        if (model.selectType == CollectionViewSelectTypeEmpty) {
            model.selectType = CollectionViewSelectTypeOption;
            if (![self.selectDaysArr containsObject:model]){
                [self.selectDaysArr addObject:model];
            }
        }
        
    }
        cell.model = model;

    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonthArr objectAtIndex:indexPath.section];
        DHCalendarDayModel *model = [month_Array objectAtIndex:15];
        
       DHCalendarMonthCollectionHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:monthHeaderId forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu年 %lu月",(unsigned long)model.year,(unsigned long)model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}

- (void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DHCalendarCollectionViewCell * cell = (DHCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *months = [self.calendarMonthArr objectAtIndex:indexPath.section];
    DHCalendarDayModel *model = [months objectAtIndex:indexPath.row];
    if([self.delegate respondsToSelector:@selector(dh_CalendarControllerDidCollectionViewItemClickWithCalendarDayModel:)]){
        [self.delegate dh_CalendarControllerDidCollectionViewItemClickWithCalendarDayModel:model];
    }
    if (!model.isEdit) {
         NSLog(@"not option");
        return;
    }
    if(model.selectType == CollectionViewSelectTypeEmpty){
        model.selectType = CollectionViewSelectTypeOption;
        if (![self.selectDaysArr containsObject:model]){
            [self.selectDaysArr addObject:model];
        }
    }else if (model.selectType == CollectionViewSelectTypeOption) { //发起预约
        model.selectType = CollectionViewSelectTypeEmpty;
//        if ([self.delegate respondsToSelector:@selector(dh_CalenderControllerBeginAppointWithCalendarDayModel:andOption:)]) {
//            BOOL ret =  [self.delegate dh_CalenderControllerBeginAppointWithCalendarDayModel:model    andOption:self.optionDays];
//            if(ret){
//                model.selectType = CollectionViewSelectTypeAppoint;
//            }
//        }
    }else if (model.selectType == CollectionViewSelectTypeAppoint){ //取消预约
        model.selectType = CollectionViewSelectTypeEmpty;
        model.orderModel.startTime = nil;
        model.orderModel.endTime = nil;
        model.orderModel.price = nil;
//        if ([self.delegate respondsToSelector:@selector(dh_CalenderControllerCancelAppointWithCalendarDayModel:andOption:)]) {
//            BOOL ret = [self.delegate dh_CalenderControllerCancelAppointWithCalendarDayModel:model andOption:self.optionDays];
//            if(ret){
//                model.selectType = CollectionViewSelectTypeEmpty;
//            }
//        }
    }
    cell.model = model;
    //    [self.collectionView reloadData];
}
-(void)dealloc {
#if !__has_feature(objc_arc)
    [self.collectionView release];
    [super dealloc];
#endif
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
