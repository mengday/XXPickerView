//
//  ViewController.m
//  XXDateViewExample
//
//  Created by Macmini on 2017/2/4.
//  Copyright © 2017年 Macmini. All rights reserved.
//

#import "ViewController.h"
#import "XXTextField.h"
#import "XXInputView.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define RandomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XXTextField *textField;
@property (weak, nonatomic) XXInputView *inputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *dataSourceFor2Column = @[@{@"1": @[@"1-1", @"1-2", @"1-3", @"1-4", @"1-5", @"1-6", @"1-7"]},
                                      @{@"2": @[@"2-1", @"2-2", @"2-3", @"2-4", @"2-5", @"2-6", @"2-7", @"2-8"]},
                                      @{@"3": @[@"3-1", @"3-2", @"3-3", @"3-4"]},
                                      @{@"4": @[@"4-1", @"4-2", @"4-3", @"4-4", @"4-5"]},
                                      @{@"5": @[@"5-1", @"5-2", @"5-3", @"5-4", @"5-5", @"5-6"]}
                                      ];
    
    
    NSArray *dataSourceFor3Column = @[@{@"1": @[@{@"1-1":@[@"1-1-1", @"1-1-2", @"1-1-3", @"1-1-4", @"1-1-5", @"1-1-6"]},
                                                @{@"1-2":@[@"1-2-1", @"1-2-2", @"1-2-3", @"1-2-4", @"1-2-5", @"1-2-6", @"1-2-7"]},
                                                @{@"1-3":@[@"1-3-1", @"1-3-2", @"1-3-3", @"1-3-4", @"1-3-5", @"1-3-6", @"1-3-7"]}
                                      ]},
                                      @{@"2": @[@{@"2-1":@[@"2-1-1", @"2-1-2", @"2-1-3", @"2-1-4", @"2-1-5", @"2-1-6"]},
                                                @{@"2-2":@[@"2-2-1", @"2-2-2", @"2-2-3", @"2-2-4", @"2-2-5", @"2-2-6", @"2-2-7"]},
                                                @{@"2-3":@[@"2-3-1", @"2-3-2", @"2-3-3", @"2-3-4", @"2-3-5", @"2-3-6", @"2-3-7"]},
                                                @{@"2-4":@[@"2-4-1", @"2-4-2", @"2-4-3", @"2-4-4", @"2-4-5", @"2-4-6", @"2-4-7"]}
                                                ]},
                                      @{@"3": @[@{@"3-1":@[@"3-1-1", @"3-1-2", @"3-1-3", @"3-1-4", @"3-1-5", @"3-1-6"]},
                                                @{@"3-2":@[@"3-2-1", @"3-2-2", @"3-2-3", @"3-2-4", @"3-2-5", @"3-2-6", @"3-2-7"]},
                                                @{@"3-3":@[@"3-3-1", @"3-3-2", @"3-3-3", @"3-3-4", @"3-3-5", @"3-3-6", @"3-3-7"]},
                                                @{@"3-4":@[@"3-4-1", @"3-4-2", @"3-4-3", @"3-4-4", @"3-4-5", @"3-4-6", @"3-4-7"]}
                                                ]},
                                      @{@"4": @[@{@"4-1":@[@"4-1-1", @"4-1-2", @"4-1-3", @"4-1-4", @"4-1-5", @"4-1-6"]},
                                                @{@"4-2":@[@"4-2-1", @"4-2-2", @"4-2-3", @"4-2-4", @"4-2-5", @"4-2-6", @"4-2-7"]},
                                                @{@"4-3":@[@"4-3-1", @"4-3-2", @"4-3-3", @"4-3-4", @"4-3-5", @"4-3-6", @"4-3-7"]},
                                                @{@"4-4":@[@"4-4-1", @"4-4-2", @"4-4-3", @"4-4-4", @"4-4-5", @"4-4-6", @"4-4-7"]},
                                                @{@"4-5":@[@"4-5-1", @"4-5-2", @"4-5-3", @"4-5-4", @"4-5-5", @"4-5-6", @"4-5-7"]}
                                                ]}
                                    ];
//-----------------------------纯代码-------------------------------
    CGFloat x = 170;
    CGFloat width = 178;
    CGFloat height = 30;
    CGFloat margin = 50;
    
    // 模式一
    XXTextField *textField = [[XXTextField alloc] init];
    textField.frame = CGRectMake(x, 28, width, height);
    textField.mode = XXPickerViewModeDate;
    textField.backgroundColor = RandomColor;
    [self.view addSubview:textField];
    
    // 模式二
    XXTextField *textField2 = [[XXTextField alloc] init];
    textField2.frame = CGRectMake(x, textField.frame.origin.y + margin, width, height);
    textField2.mode = XXPickerViewModeYearAndMonth;
    textField2.backgroundColor = RandomColor;
    [self.view addSubview:textField2];
    
    // 模式三
    XXTextField *textField3 = [[XXTextField alloc] init];
    textField3.frame = CGRectMake(x, textField2.frame.origin.y + margin, width, height);
    textField3.mode = XXPickerViewModeHourAndMinute;
    textField3.backgroundColor = RandomColor;
    [self.view addSubview:textField3];
    
    // 模式四
    XXTextField *textField4 = [[XXTextField alloc] init];
    textField4.frame = CGRectMake(x, textField3.frame.origin.y + margin, width, height);
    textField4.mode = XXPickerViewModeProvinceCity;
    textField4.backgroundColor = RandomColor;
    [self.view addSubview:textField4];
    
    // 模式五
    XXTextField *textField5 = [[XXTextField alloc] init];
    textField5.frame = CGRectMake(x, textField4.frame.origin.y + margin, width, height);
    textField5.mode = XXPickerViewModeProvinceCityAreas;
    textField5.backgroundColor = RandomColor;
    [self.view addSubview:textField5];
    
    // 模式六
    XXTextField *textField6 = [[XXTextField alloc] init];
    textField6.frame = CGRectMake(x, textField5.frame.origin.y + margin, width, height);
    textField6.mode = XXPickerViewModeDataSourceFor2Column;
    textField6.dataSource = [dataSourceFor2Column mutableCopy];
    textField6.backgroundColor = RandomColor;
    [self.view addSubview:textField6];

    // 模式七
    XXTextField *textField7 = [[XXTextField alloc] init];
    textField7.frame = CGRectMake(x, textField6.frame.origin.y + margin, width, height);;
    textField7.mode = XXPickerViewModeDataSourceFor3Column;
    textField7.dataSource = [dataSourceFor3Column mutableCopy];
    textField7.backgroundColor = RandomColor;
    [self.view addSubview:textField7];
    
    
//-----------------------------XIB-------------------------------
    _textField.mode = XXPickerViewModeDate;
    
    NSLog(@"%@", _textField.backgroundColor);
//    _textField.mode = XXPickerViewModeYearAndMonth;
//    _textField.mode = XXPickerViewModeHourAndMinute;
//    _textField.mode = XXPickerViewModeProvinceCity;
//    _textField.mode = XXPickerViewModeProvinceCityAreas;
    
//    _textField.mode = XXPickerViewModeDataSourceFor2Column;
//    _textField.dataSource = [dataSourceFor2Column mutableCopy];
    
//    _textField.mode = XXPickerViewModeDataSourceFor3Column;
//    _textField.dataSource = [dataSourceFor3Column mutableCopy];
}


//-----------------------------事件触发-------------------------------
- (IBAction)showClicked:(id)sender {
    [self.inputView show];
}

- (XXInputView *)inputView {
    if (_inputView == nil) {
        XXInputView *inputView = [[XXInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 200) mode:XXPickerViewModeDate dataSource:nil];
        inputView.hideSeparator = YES;
        inputView.completeBlock = ^(NSString *dateString){
            NSLog(@"selected data : %@", dateString);
        };
        
        [self.view addSubview:inputView];
        
        self.inputView = inputView;
    }
    
    return _inputView;
}

@end
