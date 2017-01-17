//
//  XSLineChartData.h
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XSLineChartDataItem;

typedef XSLineChartDataItem *(^LCLineChartDataGetter)(NSUInteger item);

@interface XSLineChartData : NSObject

@property (strong) UIColor *color;
@property (nonatomic) CGFloat alpha;
@property NSUInteger itemCount;
@property (copy) LCLineChartDataGetter getData;
@property (strong, nonatomic) NSString *dataTitle;

@property (nonatomic) BOOL showPointLabel;
@property (nonatomic) UIColor *pointLabelColor;
@property (nonatomic) UIFont *pointLabelFont;
@property (nonatomic) NSString *pointLabelFormat;

@property (nonatomic) UIColor *inflexionPointColor;

/// 圆的直径
@property (nonatomic, assign) CGFloat inflexionPointWidth;

@property (nonatomic, assign) CGFloat lineWidth;

@end
