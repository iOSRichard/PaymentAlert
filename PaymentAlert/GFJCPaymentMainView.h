//
//  GFJCPaymentMainView.h
//  PaymentAlert
//
//  Created by 刘军军 on 2018/2/9.
//  Copyright © 2018年 Richard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^callBack)(NSString *valure, BOOL isPay);
@interface GFJCPaymentMainView : UIView

@property (nonatomic, strong)UITextField *passwordField;

@property (nonatomic, copy) callBack isPay;

@end
