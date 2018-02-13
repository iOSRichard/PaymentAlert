//
//  GFJCPaymentMainView.m
//  PaymentAlert
//
//  Created by 刘军军 on 2018/2/9.
//  Copyright © 2018年 Richard. All rights reserved.
//

#import "GFJCPaymentMainView.h"

@interface GFJCPaymentMainView()

@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIView *orderContentView;
@property (nonatomic, strong)UIView *cardContentView;
@property (nonatomic, strong)UIView *paymentView;

@property (nonatomic, strong)UIImageView *quitImgeView;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *orderDetails;

@property (nonatomic, strong)UILabel *cardDetails;

@property (nonatomic, strong)UIButton *payButton;

@property (nonatomic, strong)UILabel *showPriceLabel;

@end

static const CGFloat KSubViewH = 50;

@implementation GFJCPaymentMainView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //头部标题
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        [self makeTopViewUI];
        [self addSubview:_topView];
        
         //订单信息
        _orderContentView = [[UIView alloc]init];
        _orderContentView.backgroundColor = [UIColor whiteColor];
        
         //付款卡片
        _cardContentView = [[UIView alloc]init];
        _cardContentView.backgroundColor = [UIColor whiteColor];
        
        [self makeContentViewUI];
        [self addSubview:_orderContentView];
        [self addSubview:_cardContentView];
        
        //支付密码
        _paymentView = [[UIView alloc]init];
        _paymentView.backgroundColor = [UIColor whiteColor];
        [self makePaymentViewUI];
        [self addSubview:_paymentView];
        
        //确认付款
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"确认付款" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setBackgroundColor:[UIColor redColor]];
        [_payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_payButton];
        
        _showPriceLabel = [[UILabel alloc]init];
        _showPriceLabel.text = @"需付款:2493.00元";
        _showPriceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_showPriceLabel];
        
    }
    return self;
    
}

#pragma mark -- 界面布局
- (void)layoutSubviews{
    
    _topView.frame = CGRectMake(0, 0, self.frame.size.width, KSubViewH);
    
    _orderContentView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame)+10, self.frame.size.width, KSubViewH);
    
    _cardContentView.frame = CGRectMake(0, CGRectGetMaxY(_orderContentView.frame)+3, self.frame.size.width, KSubViewH);
    
     _paymentView.frame = CGRectMake(0, CGRectGetMaxY(_cardContentView.frame)+10, self.frame.size.width, KSubViewH);
    
    _payButton.frame = CGRectMake(20, self.frame.size.height-70, self.frame.size.width-40, 40);
    
    _showPriceLabel.frame = CGRectMake(20, CGRectGetMaxY(_payButton.frame)-80, self.frame.size.width-40, 40);
    
}

#pragma mark -- 事件处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_passwordField resignFirstResponder];
    
}

- (void)quiteCurrentView:(id)sinder{
    NSLog(@"quiteCurrentViewquiteCurrentView");
    self.isPay(@"0", NO);
}

- (void)payButtonClick:(id)sinder{
    NSLog(@"payButtonClickpayButtonClick");
    self.isPay(@"123456", NO);
}

#pragma mark -- 绘制UI界面

- (void)makePaymentViewUI{
    UILabel *passWordTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, KSubViewH)];
    passWordTitle.text = @"支付密码";
    passWordTitle.textAlignment = NSTextAlignmentCenter;
    [_paymentView addSubview:passWordTitle];
    
    _passwordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passWordTitle.frame), 0, self.frame.size.width-passWordTitle.frame.size.width, KSubViewH)];
    _passwordField.placeholder = @"请输入6位数字";
    [_paymentView addSubview:_passwordField];
    
    
    
}

- (void)makeContentViewUI{
    UILabel *orderTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, KSubViewH)];
    orderTitle.text = @"订单信息";
    orderTitle.textAlignment = NSTextAlignmentCenter;
    [_orderContentView addSubview:orderTitle];
    
    _orderDetails = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(orderTitle.frame), 0, self.frame.size.width-orderTitle.frame.size.width, KSubViewH)];
    _orderDetails.text = @"Apple iPad 9.7英寸 WLAN版 A9 芯片什么为了凑数字数";
    _orderDetails.textAlignment = NSTextAlignmentLeft;
    [_orderContentView addSubview:_orderDetails];
    
    UILabel *cardTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, KSubViewH)];
    cardTitle.text = @"付款卡片";
    cardTitle.textAlignment = NSTextAlignmentCenter;
    [_cardContentView addSubview:cardTitle];
    
    _cardDetails = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(orderTitle.frame), 0, self.frame.size.width-orderTitle.frame.size.width, KSubViewH)];
    _cardDetails.text = @"广发京东卡(9213)";
    _cardDetails.textAlignment = NSTextAlignmentLeft;
    [_cardContentView addSubview:_cardDetails];
    
}

- (void)makeTopViewUI{
    _quitImgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav_icon_close"]];
    _quitImgeView.frame = CGRectMake(0, 0, KSubViewH, KSubViewH);
    _quitImgeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quiteCurrentView:)];
    [_quitImgeView addGestureRecognizer:tap];
    [_topView addSubview:_quitImgeView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, KSubViewH)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"付款详情";
    [_topView addSubview:_titleLabel];
    
}



@end
