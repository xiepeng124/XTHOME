//
//  XTTabbar.h
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,XTHomeItemType) {
    XTHomeTypeHome = 100,
    XTHomeTypeSchool,
    XTHomeTypeShare,
    XTHomeTypeMe,
    
};
@class XTTabbar;
typedef void (^TabBlock)(XTTabbar * tabbar,XTHomeItemType index);
@protocol XTTabBardelegate <NSObject>
-(void)tabbar:(XTTabbar*)tabbar clickButton:(XTHomeItemType) index;
@end
@interface XTTabbar : UIView
@property (weak,nonatomic) id<XTTabBardelegate>delegate;
@property (copy,nonatomic) TabBlock XTTabbarBlock;
@end
