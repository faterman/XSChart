//
//  XSLineChartDataItem.m
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSLineChartDataItem.h"

@interface XSLineChartDataItem ()

- (id)initWithY:(CGFloat)y andRawY:(CGFloat)rawY;

@property (readwrite) CGFloat y;
@property (readwrite) CGFloat rawY;
@end

@implementation XSLineChartDataItem
+ (XSLineChartDataItem *)dataItemWithY:(CGFloat)y
{
    return [[XSLineChartDataItem alloc] initWithY:y andRawY:y];
}

+ (XSLineChartDataItem *)dataItemWithY:(CGFloat)y andRawY:(CGFloat)rawY {
    return [[XSLineChartDataItem alloc] initWithY:y andRawY:rawY];
}

- (id)initWithY:(CGFloat)y andRawY:(CGFloat)rawY
{
    if ((self = [super init])) {
        self.y = y;
        self.rawY = rawY;
    }
    
    return self;
}
@end
