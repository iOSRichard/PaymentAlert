//
//  CGBPushMessageAlert.m
//  vvvv
//
//  Created by 刘军军 on 2019/3/28.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "CGBPushMessageAlert.h"

@interface CGBPushMessageAlert()

@end

@implementation CGBPushMessageAlert

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor purpleColor];
        
        self.layer.shadowColor = [UIColor redColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 5;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.layer.cornerRadius = 20;
        _imageView.clipsToBounds = YES;
        _imageView.image = [UIImage imageNamed:@"新消息推送"];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushMessageImageViewTap:)];
        [_imageView addGestureRecognizer:tap];
        
        [self addSubview:_imageView];
        
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.text = @"主人~您有任务已完成,快去领取奖励吧!";
        
        [self addSubview:_messageLabel];
        
        
    }
    return self;
}

- (void)pushMessageImageViewTap:(id)sender{
    NSLog(@"imageViewTap");
    if (_didClick) {
        _didClick();
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _messageLabel.frame = CGRectMake(20, 60, self.frame.size.width-99-20, 40);
    
}

- (void)show{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
        
        
    }];
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    if (newWindow != nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });

    }
}


@end
