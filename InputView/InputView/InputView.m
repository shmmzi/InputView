//
//  InputView.m
//
//  Created by xhw on 16/6/20.
//  Copyright © 2016年 yougoo. All rights reserved.
//

#import "InputView.h"

#define kInputViewHeight 48.0
#define kInputViewMargin 6.0

#define kInputViewLeftImgWidth 60.0
#define kInputViewRightImgWidth 60.0

@interface InputView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation InputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addAllSubviews];
        
        [self addTarget:self action:@selector(customResignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
        
        [self addNotificationObservers];
    }
    return self;
}

- (void)dealloc
{
    [self removeNotificationObservers];
}

#pragma mark - Notifications

-(void) addNotificationObservers{
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:)
     name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void) removeNotificationObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    

    [UIView animateWithDuration:duration animations:^{
        self.inputBG.y = self.height - keyboardF.size.height - self.inputBG.height;
    }];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text && textView.text.length > 0)
    {
        _rightBtn.enabled = YES;
    }
    else
    {
        _rightBtn.enabled = NO;
    }
}

#pragma mark - public

- (void)customResignFirstResponder
{
    self.hidden = YES;
    [self.textView resignFirstResponder];
}

- (void)customBecomeFirstResponder
{
    self.hidden = NO;
    [self.textView becomeFirstResponder];
}

//发送成功后清空输入框内容
- (void)clearText
{
    self.textView.text = @"";
}

#pragma mark - 点击事件

- (void)leftBtnAction
{
    if([self.delegate respondsToSelector:@selector(inputViewWillPickImage:)])
    {
        [self.delegate inputViewWillPickImage:self];
    }
    
    [self customResignFirstResponder];
}

- (void)rightBtnAction
{
    if(self.textView.text && self.textView.text.length > 0)
    {
        if([self.delegate respondsToSelector:@selector(inputView:willSendText:)])
        {
            [self.delegate inputView:self willSendText:self.textView.text];
        }
    }
    
    [self customResignFirstResponder];
}

#pragma mark - lazy

- (UIImageView *)inputBG
{
    if(!_inputBG)
    {
        _inputBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height,self.width, kInputViewHeight)];
        _inputBG.backgroundColor = [UIColor grayColor];
        _inputBG.userInteractionEnabled = YES;
    }
    return _inputBG;
}

- (UITextView *)textView
{
    if(!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(kInputViewLeftImgWidth + kInputViewMargin * 2, kInputViewMargin, self.inputBG.width - kInputViewLeftImgWidth - kInputViewRightImgWidth - kInputViewMargin*4, kInputViewHeight - kInputViewMargin*2)];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kInputViewMargin, kInputViewMargin, kInputViewLeftImgWidth, kInputViewHeight - kInputViewMargin*2)];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:186/255.0 blue:61/255.0 alpha:1.0]];
         [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [_leftBtn setTitle:@"图片" forState:UIControlStateNormal];
         _leftBtn.layer.masksToBounds = YES;
         _leftBtn.layer.cornerRadius = 3;

    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if(!_rightBtn)
    {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.inputBG.width - kInputViewMargin - kInputViewRightImgWidth, kInputViewMargin, kInputViewRightImgWidth, kInputViewHeight - kInputViewMargin*2)];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:186/255.0 blue:61/255.0 alpha:1.0]];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"发送" forState:UIControlStateNormal];
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.layer.cornerRadius = 3;
        _rightBtn.enabled = NO;
    }
    return _rightBtn;
}

- (void)addAllSubviews {
    [self addSubview:self.inputBG];
    [self.inputBG addSubview:self.leftBtn];
    [self.inputBG addSubview:self.textView];
    [self.inputBG addSubview:self.rightBtn];
}

@end
