//
//  CGBPushMessageAlert.h
//  vvvv
//
//  Created by 刘军军 on 2019/3/28.
//  Copyright © 2019 Richard. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGBPushMessageAlert : UIView

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UILabel *messageLabel;

@property (nonatomic,copy) void(^didClick)(void);

- (void)show;

@end

NS_ASSUME_NONNULL_END
