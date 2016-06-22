//
//  InputView.h
//
//  Created by xhw on 16/6/20.
//  Copyright © 2016年 yougoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+Extension.h"

@class InputView;

@protocol UGUWorkOrderInputViewDelegate <NSObject>

- (void)inputView:(InputView *)inputView willSendText:(NSString *)text;
- (void)inputViewWillPickImage:(InputView *)inputView;

@end

@interface InputView : UIControl

@property (nonatomic, strong) UIImageView *inputBG;

@property (nonatomic, assign) id <UGUWorkOrderInputViewDelegate> delegate;


- (void)customResignFirstResponder;
- (void)customBecomeFirstResponder;

@end
