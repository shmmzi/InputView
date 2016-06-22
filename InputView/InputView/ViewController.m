//
//  ViewController.m
//  InputView
//
//  Created by xhw on 16/6/22.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "ViewController.h"
#import "InputView.h"

@interface ViewController ()<UGUWorkOrderInputViewDelegate>

@property (nonatomic, strong) InputView *inputView;

@property (nonatomic, strong) UIButton *msgButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.msgButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - click
- (void)msgButtonClick {
    NSLog(@"\n-----> %s", __func__);
    [self.view bringSubviewToFront:self.inputView];
    [self.inputView customBecomeFirstResponder];
}

#pragma mark - lazy

- (UIButton *)msgButton {
    if (!_msgButton) {
        _msgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _msgButton.frame = CGRectMake(100, 100, 100, 40);
        [_msgButton setTitle:@"留言" forState:UIControlStateNormal];
        [_msgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_msgButton addTarget:self action:@selector(msgButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgButton;
}

- (InputView *)inputView
{
    if(!_inputView)
    {
        _inputView = [[InputView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_inputView];
        _inputView.hidden = YES;
        _inputView.delegate = self;
    }
    return _inputView;
}

#pragma mark - UGUWorkOrderInputViewDelegate

- (void)inputView:(InputView *)inputView willSendText:(NSString *)text
{
    NSLog(@"发送文字--%@",text);
}

- (void)inputViewWillPickImage:(InputView *)inputView
{
    NSLog(@"选择图片");
}
@end
