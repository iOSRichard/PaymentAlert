//
//  GFJCPaymentAlertView.m
//  PaymentAlert
//
//  Created by 刘军军 on 2018/2/9.
//  Copyright © 2018年 Richard. All rights reserved.
//

#import "GFJCPaymentAlertView.h"
#import "GFJCPaymentMainView.h"
@interface GFJCPaymentAlertView()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *mainViewBg;
@property (nonatomic, strong)GFJCPaymentMainView *mainView;
@end

@implementation GFJCPaymentAlertView

#pragma mark - 单例

static id _instance;

+ (instancetype)sharedPaymentAlertView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    });
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [GFJCPaymentAlertView sharedPaymentAlertView] ;
}

-(id) copyWithZone:(NSZone *)zone
{
    return [GFJCPaymentAlertView sharedPaymentAlertView] ;
}

-(id) mutablecopyWithZone:(NSZone *)zone
{
    return [GFJCPaymentAlertView sharedPaymentAlertView] ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
         _mainViewBg = [[UIView alloc]initWithFrame:self.frame];
         _mainViewBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mainViewBg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        _mainViewBg.alpha = 0;
        [self addSubview:_mainViewBg];
        
        _mainView = [[GFJCPaymentMainView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 400)];
        _mainView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
        _mainView.passwordField.delegate = self;
        
        [self addSubview:_mainView];

        
        //第一种写法
//        __weak typeof(self) weakSelf = self;
//        _mainView.isPay = ^(NSString *valure, BOOL isPay) {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            strongSelf.resultCallBack(valure, isPay);
//            [strongSelf dismiss];
//        };
        
        //第二种写法
        __weak typeof(self) weakSelf = self;
        [_mainView setIsPay:^(NSString *valure, BOOL isPay) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.resultCallBack(valure, isPay);
            [strongSelf dismiss];
        }];
        
    }
    return self;
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-500, [UIScreen mainScreen].bounds.size.width, 500);
    } completion:^(BOOL finished) {
        
    }];
    
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-400, [UIScreen mainScreen].bounds.size.width, 400);
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
    
}

- (void)show{
    // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
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

        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _mainViewBg.alpha = 1.0f;
            _mainView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-400, [UIScreen mainScreen].bounds.size.width, 400);
        } completion:nil];
    }];
    
   

   
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _mainViewBg.alpha = 0.0f;
        _mainView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 400);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}





@end
