# XXPickerView


![示例效果图](http://img.blog.csdn.net/20170208140654859?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdmJpcmRiZXN0/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast )


### 一个常用的日期选择和自定义数据选择的自定义控件


---


### Getting Started【开始使用】

将XXPickerView文件夹拖入到自己的工程中

---
### Examples【示例】

#### 一 ：纯代码方式
```objc
#import "XXTextField.h"

@implementation ViewController

- (void)viewDidLoad {
[super viewDidLoad];

CGFloat x = 170;
CGFloat width = 178;
CGFloat height = 30;
CGFloat margin = 50;

// 模式一
XXTextField *textField = [[XXTextField alloc] init];
textField.frame = CGRectMake(x, 28, width, height);
textField.mode = XXPickerViewModeDate;
[self.view addSubview:textField];

// 模式二
XXTextField *textField2 = [[XXTextField alloc] init];
textField2.frame = CGRectMake(x, textField.frame.origin.y + margin, width, height);
textField2.mode = XXPickerViewModeYearAndMonth;
[self.view addSubview:textField2];

// 模式三
XXTextField *textField3 = [[XXTextField alloc] init];
textField3.frame = CGRectMake(x, textField2.frame.origin.y + margin, width, height);
textField3.mode = XXPickerViewModeHourAndMinute;
[self.view addSubview:textField3];

// 模式四
XXTextField *textField4 = [[XXTextField alloc] init];
textField4.frame = CGRectMake(x, textField3.frame.origin.y + margin, width, height);
textField4.mode = XXPickerViewModeProvinceCity;
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
}
@end
```


#### 二：XIB方式（拖线并设置模式）
```objc
@interface ViewController ()
@property (weak, nonatomic) IBOutlet XXTextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
[super viewDidLoad];
_textField.mode = XXPickerViewModeDate;
}

@end
```

#### 三：事件触发方式（创建XXInputView并显示）
```objc
#import "ViewController.h"
#import "XXInputView.h"

@interface ViewController ()
@property (weak, nonatomic) XXInputView *inputView;
@end

@implementation ViewController

- (void)viewDidLoad {
[super viewDidLoad];
}

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
```

---
### Detailed Introduction【详细介绍】
[详细介绍](http://blog.csdn.net/vbirdbest/article/details/54924535)
