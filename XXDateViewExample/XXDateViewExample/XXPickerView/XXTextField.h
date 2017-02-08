//
//  XXDateTextField.h
//  XXDateViewExample
//
//  Created by Macmini on 2017/2/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XXInputView.h"

@interface XXTextField : UITextField

@property (assign, nonatomic) XXPickerViewMode mode;
@property (strong, nonatomic) NSMutableArray *dataSource;


- (instancetype)initWithFrame:(CGRect)frame mode:(XXPickerViewMode)mode;
- (instancetype)initWithFrame:(CGRect)frame mode:(XXPickerViewMode)mode dataSource:(NSMutableArray *)dataSource;

@end
