//
//  XTHttpbase.h
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id object);
typedef void(^FailedBlock)(id object);
typedef void(^UploadBlock)(NSProgress *progress);
@interface XTHttpbase : NSObject

@end
