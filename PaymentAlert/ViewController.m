//
//  ViewController.m
//  PaymentAlert
//
//  Created by 刘军军 on 2018/2/8.
//  Copyright © 2018年 Richard. All rights reserved.
//

#import "ViewController.h"
#import "GFJCPaymentAlertView.h"

@interface ViewController ()

@property (nonatomic, strong)UIButton *button;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(50, 150, 150, 40);
    [_button setTitle:@"付款" forState: UIControlStateNormal];
    [_button setBackgroundColor:[UIColor redColor]];
    [_button setTintColor:[UIColor blueColor]];
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
   
//    __weak typeof(self) weakSelf = self;
    [GFJCPaymentAlertView sharedPaymentAlertView].resultCallBack = ^(NSString* value, BOOL isSure){
        
    };
    
    
}

- (void)buttonClick:(UIButton *)button{
    
    NSLog(@"buttonClickbuttonClick");
    
    [[GFJCPaymentAlertView sharedPaymentAlertView] show];
   
    
}




@end
