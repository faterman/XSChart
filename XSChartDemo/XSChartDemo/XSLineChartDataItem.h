//
//  XSLineChartDataItem.h
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XSLineChartDataItem : NSObject
+ (XSLineChartDataItem *)dataItemWithY:(CGFloat)y;
+ (XSLineChartDataItem *)dataItemWithY:(CGFloat)y andRawY:(CGFloat)rawY;

@property (readonly) CGFloat y; // should be within the y range
@property (readonly) CGFloat rawY; // this is the raw value, used for point label.
@end
