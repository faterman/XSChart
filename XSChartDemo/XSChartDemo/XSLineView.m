//
//  XSLineView.m
//  XSChartDemo
//
//  Created by faterman on 17/2/16.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSLineView.h"
#import "XSChartLabel.h"
#import "XSChartColor.h"
#import "XSLineChart.h"
#import "XSLineChartData.h"
#import "XSLineChartDataItem.h"
//static const float p_YAxisOffset = 10.f;
static const float p_CharMargin  = 25.f;
//static const float xLabelWidth = 80.f;
@implementation XSLineView
{
    UIScrollView *_scrollView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithFrame:(CGRect)frame{
//
//    
//}
- (instancetype)initWithFrame:(CGRect)frame XLabels:(NSArray *)xLabels DataArray:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        _chartCavanHeight = self.frame.size.height - 2 * p_CharMargin;
        _yLabelHeight = [[[[XSChartLabel alloc] init] font] pointSize];
        
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.contentSize = CGSizeMake(80*dataArray.count+40, 200);
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
        XSLineChart * lineChart = [[XSLineChart alloc] initWithFrame:CGRectMake(0, 0, 80*dataArray.count+40, frame.size.height)];
        [lineChart setXLabels:xLabels];
//        NSArray * dataArray = [NSArray arrayWithArray:dataArray];
        XSLineChartData *data = [XSLineChartData new];
        data.itemCount = lineChart.xLabels.count;
        data.getData = ^(NSUInteger index) {
            CGFloat yValue = [dataArray[index] floatValue];
            return [XSLineChartDataItem dataItemWithY:yValue];
        };
        lineChart.showPointLabel = NO;
        lineChart.showSmoothLines = YES;
        lineChart.chartData = data;
        [lineChart strokeChart];
        [_scrollView addSubview:lineChart];
        [self addSubview:_scrollView];
        
        [self setYLabels];
    }
    return self;
    
}
- (void)setYLabels {

    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (NSInteger) p_CharMargin+5, self.frame.size.height)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    NSInteger index = 0;
    NSInteger num = 5;
    
    while (num > 0) {
        
        index += 1;
        num -= 1;
    }
    
    for (NSUInteger i = 0; i < 5; i++) {
        
        float y = 0.0f;
        NSString * yText;
        
        switch (i) {
            case 0:  /// 20.0
                y = p_CharMargin;
                yText = @"20.0";
                break;
            case 1:
                y = _chartCavanHeight/2 + p_CharMargin;
                yText = @"10.0";
                break;
            case 2:
                y = _chartCavanHeight/2 + 3.0/20*_chartCavanHeight + p_CharMargin;
                yText = @"7.0";
                break;
            case 3:
                y = _chartCavanHeight/2 + 5.6/20*_chartCavanHeight + p_CharMargin;
                yText = @"4.4";
                break;
            case 4:
                y = _chartCavanHeight + p_CharMargin;
                yText = @"0.0";
                break;
                
            default:
                break;
        }
        
        XSChartLabel *label = [[XSChartLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, (NSInteger) p_CharMargin, (NSInteger) _yLabelHeight)];
        label.center = CGPointMake(label.center.x, y);
        [label setTextAlignment:NSTextAlignmentRight];
        label.text = yText;
        [self addSubview:label];
    }
}
@end
