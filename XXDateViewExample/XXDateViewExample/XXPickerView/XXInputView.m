//
//  XXDateView.m
//  XXDateViewExample
//
//  Created by Macmini on 2017/2/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "XXInputView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDateViewHeight 200
#define kTopViewHeight 30


@interface XXInputView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) UIView *containerView;
@property (weak, nonatomic) UIView *separatorView;
@property (weak, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSDictionary *selectedDataForColumn1;     // 用于级联
@property (strong, nonatomic) NSDictionary *selectedDataForColumn2;     // 用于级联
@property (strong, nonatomic) NSString *selectedValue;

@end

@implementation XXInputView

// 1. 初始化控件(containerView(titleBarView+contentView))
// 2. 自动布局
// 3. 设置数据

#pragma mark -
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame mode:XXPickerViewModeDate dataSource:[NSMutableArray array]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initPropertyDefaultValue];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame mode:(XXPickerViewMode)mode dataSource:(NSMutableArray *)dataSource {
    if (self = [super initWithFrame:frame]) {
        
        [self initPropertyDefaultValue];
        
        self.pickerViewMode = mode;
        
        if (dataSource != nil) {
            _dataSource = dataSource;
        } else {
            [self generateDataSource];
        }
        
        
        if (mode != XXPickerViewModeDate) {
            NSDictionary *firstDict = self.dataSource[0];
            _selectedDataForColumn1 = firstDict;
            if (mode == XXPickerViewModeDataSourceFor3Column || mode == XXPickerViewModeProvinceCityAreas) {
                NSArray *allCitys = firstDict.allValues[0];
                NSDictionary *fistCityDict = allCitys[0];
                _selectedDataForColumn2 = fistCityDict;
            }
        }
        
        
        [self setupUI];
    }
    
    return self;
}

- (void)initPropertyDefaultValue {
    _dataSource = [NSMutableArray array];
    
    _pickerViewMode = XXPickerViewModeDataSourceFor2Column;
    
    _attributesTitle = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],
                            NSForegroundColorAttributeName : [UIColor blueColor]};
    
    _hideSeparator = NO;
    
    _separatorColor = [UIColor blackColor];
}

- (void)setupUI {
    // containerView(容器视图，默认隐藏)
    [self addContainerView];

    // titleBarView
    [self addTitleBarView];
    
    // 分割线
    [self addSeparatorView];
    
    // Content
    [self addContentView];
}


- (void)addContainerView {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kDateViewHeight)];
    containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:containerView];
    self.containerView = containerView;
}

- (void)addTitleBarView {
    UIView *titleBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kTopViewHeight)];

    // CancelButton
    CGFloat titleButtonWidth = 80;
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleButtonWidth, kTopViewHeight)];
    cancelButton.backgroundColor = [UIColor whiteColor];
    
    // 解决属性赋值先后问题
    NSAttributedString *cancelTitleAttStr = [[NSAttributedString alloc] initWithString:@"取消" attributes:self.attributesTitle];
    [cancelButton setAttributedTitle:cancelTitleAttStr forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [titleBarView addSubview:cancelButton];
    
    // OKButton
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - titleButtonWidth, 0, titleButtonWidth, kTopViewHeight)];
    okButton.backgroundColor = [UIColor whiteColor];
    NSAttributedString *okTitleAttStr = [[NSAttributedString alloc] initWithString:@"确定" attributes:self.attributesTitle];
    [okButton setAttributedTitle:okTitleAttStr forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [titleBarView addSubview:okButton];
    [self.containerView addSubview:titleBarView];
}

- (void)addSeparatorView {
    if (_hideSeparator) return;
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopViewHeight + 1, ScreenWidth, 1)];
    separatorView.backgroundColor = self.separatorColor;
    [self.containerView addSubview:separatorView];
    self.separatorView = separatorView;
}

- (void)addContentView {
    switch (self.pickerViewMode) {
        case XXPickerViewModeDate:
            [self addDatePicker];
            break;
        case XXPickerViewModeYearAndMonth:
        case XXPickerViewModeHourAndMinute:
        case XXPickerViewModeProvinceCity:
        case XXPickerViewModeProvinceCityAreas:
        case XXPickerViewModeDataSourceFor2Column:
        case XXPickerViewModeDataSourceFor3Column:
            [self addPickerView];
            break;
        default:
            break;
    }
}

- (void)addDatePicker {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, kTopViewHeight + 2, ScreenWidth, kDateViewHeight - kTopViewHeight);
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker = datePicker;
    [self.containerView addSubview:datePicker];
}


- (void)addPickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kTopViewHeight + 2, ScreenWidth, kDateViewHeight - kTopViewHeight)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    self.pickerView = pickerView;
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    [self.containerView addSubview:pickerView];
}


#pragma mark -
#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_pickerViewMode == XXPickerViewModeYearAndMonth
        || _pickerViewMode == XXPickerViewModeHourAndMinute
        || _pickerViewMode == XXPickerViewModeProvinceCity
        || _pickerViewMode == XXPickerViewModeDataSourceFor2Column) {
        return 2;
    } else if (_pickerViewMode == XXPickerViewModeDataSourceFor3Column || _pickerViewMode == XXPickerViewModeProvinceCityAreas) {
        return 3;
    }
    
    return 0;   // 暂不支持4列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataSource.count;
    } else if (component == 1) {
        NSArray *allCitys = self.selectedDataForColumn1.allValues[0];
        return allCitys.count;
    }
    
    
    if ((self.pickerViewMode == XXPickerViewModeDataSourceFor3Column || self.pickerViewMode == XXPickerViewModeProvinceCityAreas) && component == 2) {
        NSArray *allDists = self.selectedDataForColumn2.allValues[0];
        
        return allDists.count;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        NSDictionary *dict = self.dataSource[row];
        NSString *key = dict.allKeys[0];
        return key;
    } else if (component == 1) {
        if (self.pickerViewMode == XXPickerViewModeDataSourceFor3Column || self.pickerViewMode == XXPickerViewModeProvinceCityAreas) {
            NSArray *cityArray = self.selectedDataForColumn1.allValues[0];
            NSDictionary *cityDict = cityArray[row];
            NSString *cityKey = cityDict.allKeys[0];
            return cityKey;
        } else {
            NSString *provinceKey = self.selectedDataForColumn1.allKeys[0];
            NSArray *cityArray = self.selectedDataForColumn1[provinceKey];
            NSString *cityName = cityArray[row];
            
            return cityName;
        }
    } else if (component == 2) {
        NSArray *allDists = self.selectedDataForColumn2.allValues[0];
        return allDists[row];
    }
    
    return @" ？？？";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger row1 = [pickerView selectedRowInComponent:0];
    NSDictionary *dict = self.dataSource[row1];
    NSString *column1 = dict.allKeys[0];

    
    NSString *column2 = nil;
    NSString *column3 = @"";
    if (self.pickerViewMode != XXPickerViewModeDataSourceFor3Column && self.pickerViewMode != XXPickerViewModeProvinceCityAreas) {
        NSArray *areas = dict.allValues[0];
        if (component == 0) {
            column2 = areas[0];
        } else if (component == 1) {
            column2 = areas[row];
        }
    } else {
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSArray *allCitys = dict.allValues[0];
        NSDictionary *cityDict = allCitys[row2];
        column2 = cityDict.allKeys[0];
        
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSArray *allDists = cityDict.allValues[0];
        column3 = [NSString stringWithFormat:@"-%@", allDists[row3]];
    }
    
    _selectedValue = [NSString stringWithFormat:@"%@-%@%@", column1, column2, column3];
    
    if (component == 0) {
        _selectedDataForColumn1 = self.dataSource[row];
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:component + 1 animated:YES];
        
        if (self.pickerViewMode == XXPickerViewModeDataSourceFor3Column || self.pickerViewMode == XXPickerViewModeProvinceCityAreas) {
            NSArray *allCitys = self.selectedDataForColumn1.allValues[0];
            _selectedDataForColumn2 = allCitys[0];
            
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:component + 1 animated:YES];
        }
    }
    

    if ((self.pickerViewMode == XXPickerViewModeDataSourceFor3Column || self.pickerViewMode == XXPickerViewModeProvinceCityAreas) && component == 1) {
        NSArray *allCitys = self.selectedDataForColumn1.allValues[0];
        _selectedDataForColumn2 = allCitys[row];
            
        [self.pickerView reloadComponent:2];
    }
}

- (void)cancelButtonClicked {
    [self hide];
}

- (void)okButtonClicked {
    if (_pickerViewMode == XXPickerViewModeDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _selectedValue = [dateFormatter stringFromDate:self.datePicker.date];
    }
    
//    areaDict = @{@"1-1":@[@"1-1-1", @"1-1-2", @"1-1-3", @"1-1-4", @"1-1-5", @"1-1-6"]}
    
    if (_selectedValue == nil) {
        NSDictionary *dict = self.dataSource[0];
        NSString *key = dict.allKeys[0]; // 1
        NSString *column2 = nil;
        NSString *column3 = @"";
        
        switch (self.pickerViewMode) {
            case XXPickerViewModeYearAndMonth:
            case XXPickerViewModeHourAndMinute:
            case XXPickerViewModeProvinceCity:
            case XXPickerViewModeDataSourceFor2Column:{
                NSArray *cityArray = dict[key];
                column2 = cityArray[0];
                break;
            }
            case XXPickerViewModeProvinceCityAreas:
            case XXPickerViewModeDataSourceFor3Column: {
                NSArray *areaDictArray = dict[key];
                NSDictionary *areaDict = areaDictArray[0];
                column2 = areaDict.allKeys[0];
                column3 = [NSString stringWithFormat:@"-%@", areaDict.allValues[0][0]];
                break;
            }
            default:
                break;
        }
        
        _selectedValue = [NSString stringWithFormat:@"%@-%@%@", key, column2, column3];
    }
    
    self.completeBlock(_selectedValue);
    [self hide];
}

// 隐藏视图
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        UIView *popView = self;
        if ([self.superview isKindOfClass:NSClassFromString(@"UIInputSetHostView")]) {
            popView = self.superview;
        }
        
        popView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, kDateViewHeight);
    }];
}

// 显示视图
- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, ScreenHeight - kDateViewHeight, ScreenWidth, kDateViewHeight);
    }];
}


#pragma mark -
#pragma mark - Override Settor
- (void)setPickerViewMode:(XXPickerViewMode)pickerViewMode {
    _pickerViewMode = pickerViewMode;
    
    // 生成数据源
    [self generateDataSource];
}

- (void)setHideSeparator:(Boolean)hideSeparator {
    _hideSeparator = hideSeparator;
    
    if (hideSeparator) {
        [self.separatorView removeFromSuperview];
    }
}


#pragma mark - 
#pragma mark - generate dataSource
- (void)generateDataSource {
    if (self.dataSource != nil && self.dataSource.count > 0) return;
        
    switch (self.pickerViewMode) {
        case XXPickerViewModeYearAndMonth:
            [self generateYearAndMonthDataSource];
            break;
        case XXPickerViewModeHourAndMinute:
            [self generateHourAndMinuteDataSource];
            break;
        case XXPickerViewModeProvinceCity:
            [self generateProvinceCityDataSource];
            break;
        case XXPickerViewModeProvinceCityAreas:
            [self generateProvinceCityAreasDataSource];
            break;
        default:
            break;
    }
}

- (void)generateYearAndMonthDataSource {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSMutableArray *column2 = [NSMutableArray arrayWithCapacity:12];
    for (int i = 1; i <= 12; i++) {
        NSString *month = [NSString stringWithFormat:@"%d月", i];
        [column2 addObject:month];
    }
    
    for (int i = 1900; i <= dateComponent.year ; i++) {
        NSString *key = [NSString stringWithFormat:@"%d年", i];
        NSDictionary *dict = @{key : column2};
        [self.dataSource addObject:dict];
    }
}

- (void)generateHourAndMinuteDataSource {
    NSMutableArray *column2 = [NSMutableArray arrayWithCapacity:12];
    for (int i = 0; i <= 59; i++) {
        NSString *minute = [NSString stringWithFormat:@"%d分钟", i];
        [column2 addObject:minute];
    }
    
    
    for (int i = 0; i < 24 ; i++) {
        NSString *key = [NSString stringWithFormat:@"%d小时", i];
        
        NSDictionary *dict = @{key : column2};
        
        [self.dataSource addObject:dict];
    }
}

- (void)generateProvinceCityDataSource {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    _dataSource = [[NSArray arrayWithContentsOfFile:path] mutableCopy];
}

- (void)generateProvinceCityAreasDataSource {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _dataSource = [[NSArray arrayWithContentsOfFile:path] mutableCopy];
}
@end
