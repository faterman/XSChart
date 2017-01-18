//
//  XSLineChart.h  线性图表,当前仅支持单条线绘制
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSGenericChart.h"

@class XSLineChartData;
@interface XSLineChart : XSGenericChart
@property (nonatomic) CGFloat chartCavanHeight;
@property (nonatomic) CGFloat chartCavanWidth;
@property (nonatomic) NSArray *xLabels;
@property (nonatomic) CGFloat yLabelHeight;
@property (nonatomic) CGFloat xLabelWidth;

/// 要绘制的数据
@property (nonatomic) XSLineChartData *chartData;
/// 是否使用弧形过渡
@property (nonatomic) BOOL showSmoothLines;
/// 显示PointLabel
@property (nonatomic) BOOL showPointLabel;

- (void)setXLabels:(NSArray *)xLabels;
/// 绘制图表
- (void)strokeChart;
/// 更新更新
- (void)updateChartData:(XSLineChartData *)data;
@end
