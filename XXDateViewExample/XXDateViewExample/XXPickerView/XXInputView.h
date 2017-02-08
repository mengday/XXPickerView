//
//  XXDateView.h
//  XXDateViewExample
//
//  Created by Macmini on 2017/2/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletedBlock)(NSString *selectedDate);
typedef NS_ENUM(NSInteger, XXPickerViewMode) {
    XXPickerViewModeDate = 0,               // yyyy-MM-dd  default
    XXPickerViewModeYearAndMonth,           // yyyy-MM
    XXPickerViewModeHourAndMinute,          // hh mm
    XXPickerViewModeProvinceCity,           // Province  City
    XXPickerViewModeProvinceCityAreas,      // Province  City  Areas
    XXPickerViewModeDataSourceFor2Column,   // custom datasource for 2 columns
    XXPickerViewModeDataSourceFor3Column    // custom datasource for 3 columns
};



@interface XXInputView : UIView

@property (nonatomic, strong) NSDictionary *attributesTitle;    // 设置“取消”和“确定”按钮的属性，用于设置标题的NSAttributedString
@property (nonatomic, strong) UIColor *separatorColor;          // 分割线颜色，高度值为1, 默认为blackColor
@property (nonatomic, assign) Boolean hideSeparator;            // 是否隐藏分割线, 默认NO
@property (nonatomic, copy) CompletedBlock completeBlock;       // 完成Block
@property (nonatomic, assign) XXPickerViewMode pickerViewMode;  // 模式

// init

// 数据源格式
// 年月：    [{2016: [1, 2, ..., 12]}, {2017: [1, 2, ..., 12]}]
// 时分：    [{0: [0, 1, ..., 59]}, {23: [0, 1, ..., 59]}]
// 自定义2列：[{"河南"：["郑州市", "商丘市"]}, {"江苏"：["南京", "苏州"]}]
// 自定义3列：[{"河南"：[{"郑州市":["金水区", "二七区"]}, {"商丘市"：["梁园区", "睢阳区"]}], "江苏"：[{"南京市":["玄武区", "栖霞区"]}, "苏州市"：["沧浪区", "平江区"]]}]
- (instancetype)initWithFrame:(CGRect)frame mode:(XXPickerViewMode)mode dataSource:(NSMutableArray *)dataSource;

// functions
- (void)show;
- (void)hide;

@end
