//
//  XXDateTextField.m
//  XXDateViewExample
//
//  Created by Macmini on 2017/2/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "XXTextField.h"
#import "XXInputView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDateViewHeight 200

@implementation XXTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _mode = XXPickerViewModeDate;       // 默认值
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame mode:(XXPickerViewMode)mode {
    if (self = [super initWithFrame:frame]) {
        self.mode = mode;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setupUI {
    XXInputView *inputView = [[XXInputView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, kDateViewHeight) mode:self.mode dataSource:self.dataSource];
    inputView.completeBlock = ^(NSString *dateString){
        self.text = dateString;
    };
    
    self.inputView = inputView;
}

- (void)setMode:(XXPickerViewMode)mode {
    _mode = mode;
    
    if (mode != XXPickerViewModeDataSourceFor2Column && mode != XXPickerViewModeDataSourceFor3Column) {
        [self setupUI];
    }
    
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    if (self.mode == XXPickerViewModeDataSourceFor2Column || self.mode == XXPickerViewModeDataSourceFor3Column) {
        [self setupUI];
    }
}

@end
