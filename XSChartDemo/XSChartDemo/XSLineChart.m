//
//  XSLineChart.m
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSLineChart.h"
#import "XSChartLabel.h"
#import "XSLineChartData.h"
#import "XSChartColor.h"
#import "XSLineChartDataItem.h"

/// Y轴偏移
static const float p_YAxisOffset = 10.f;
static const float p_CharMargin  = 25.f;
static const float xLabelWidth = 80.f;
@interface XSLineChart ()
{
    UIView *_indicatorView;
}
/// 存储线条的layer
@property(strong, nonatomic) UIBezierPath *chartPath;
@property(strong, nonatomic) CAShapeLayer *chartLine;
/// 由于各个点颜色不同，所有用Array的存储点绘制路径
@property(nonatomic) NSMutableArray<UIBezierPath *> *chartPointArray;
/// 路径绘制动画
@property(nonatomic) CABasicAnimation *pathAnimation;

@end

@implementation XSLineChart

#pragma mark initialization

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self setupDefaultValues];
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupDefaultValues];
    }
    
    return self;
}

#pragma mark private methods
- (void)setupDefaultValues {
    [super setupDefaultValues];
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    // 默认是折线图
    _showSmoothLines = NO;
    _chartCavanWidth = self.frame.size.width - 2 * p_CharMargin;
    _chartCavanHeight = self.frame.size.height - 2 * p_CharMargin;
    _yLabelHeight = [[[[XSChartLabel alloc] init] font] pointSize];
    _chartPointArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self setYLabels];
}
- (void)setXLabels:(NSArray *)xLabels {
    
    _xLabels = xLabels;
    _xLabelWidth = xLabelWidth;
    
    NSString *labelText;
    
    for (int index = 0; index < xLabels.count; index++) {
        labelText = xLabels[index];
        
        NSInteger x = index * _xLabelWidth + p_YAxisOffset + p_CharMargin;
        NSInteger y = p_CharMargin + _chartCavanHeight;
        
        XSChartLabel *label = [[XSChartLabel alloc] initWithFrame:CGRectMake(x, y, (NSInteger) _xLabelWidth, (NSInteger) p_CharMargin)];

        [label setTextAlignment:NSTextAlignmentCenter];
        label.text = labelText;
        [self addSubview:label];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, (NSInteger) _xLabelWidth, (NSInteger) p_CharMargin)];
        btn.tag = index;
        [btn addTarget:self action:@selector(tapXLabel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(p_YAxisOffset + p_CharMargin,   p_CharMargin + _chartCavanHeight-2, 30, 2)];
    _indicatorView.center = CGPointMake(_indicatorView.frame.origin.x+_xLabelWidth/2.0, _indicatorView.center.y);
    _indicatorView.backgroundColor = [UIColor redColor];
    [self addSubview:_indicatorView];
}
- (void)tapXLabel:(UIButton *)button{
    
    CGFloat yValue;
    CGFloat innerGrade;
    
    yValue = _chartData.getData(button.tag).y;
    
    innerGrade = yValue/20.0;
    
    int x = button.tag * _xLabelWidth + p_YAxisOffset + p_CharMargin + _xLabelWidth / 2.0 ;
    
    int y = _chartCavanHeight - (innerGrade * _chartCavanHeight) + (_yLabelHeight / 2) + p_CharMargin - p_CharMargin;
    
    if (self.showPointLabel) {
    
        UIView *pointLabel = [self viewWithTag:2000];
        [pointLabel removeFromSuperview];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        lable.center = CGPointMake(x, y + 20);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14.0];
        lable.text = [NSString stringWithFormat:@"%.1f",yValue];
        lable.tag = 2000;
        [self addSubview:lable];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        _indicatorView.center = CGPointMake(button.frame.origin.x+_xLabelWidth/2.0, _indicatorView.center.y);
    }];
}
- (void)setYLabels {
    
//    NSInteger index = 0;
//    NSInteger num = 5;
//    
//    while (num > 0) {
//        
//        index += 1;
//        num -= 1;
//    }
//    
//    for (NSUInteger i = 0; i < 5; i++) {
//        
//        float y = 0.0f;
//        NSString * yText;
//        
//        switch (i) {
//            case 0:  /// 20.0
//                y = p_CharMargin;
//                yText = @"20.0";
//                break;
//            case 1:
//                y = _chartCavanHeight/2 + p_CharMargin;
//                yText = @"10.0";
//                break;
//            case 2:
//                y = _chartCavanHeight/2 + 3.0/20*_chartCavanHeight + p_CharMargin;
//                yText = @"7.0";
//                break;
//            case 3:
//                y = _chartCavanHeight/2 + 5.6/20*_chartCavanHeight + p_CharMargin;
//                yText = @"4.4";
//                break;
//            case 4:
//                y = _chartCavanHeight + p_CharMargin;
//                yText = @"0.0";
//                break;
//                
//            default:
//                break;
//        }
//        
//        XSChartLabel *label = [[XSChartLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, (NSInteger) p_CharMargin, (NSInteger) _yLabelHeight)];
//        label.center = CGPointMake(label.center.x, y);
//        [label setTextAlignment:NSTextAlignmentRight];
//        label.text = yText;
//        [self addSubview:label];
//    }
}
- (void)setChartData:(XSLineChartData *)data{
    _chartData = data;
    
    
    CGFloat yValue;
    CGFloat innerGrade;
    
    yValue = _chartData.getData(0).y;
    
    innerGrade = yValue/20.0;
    int x = p_YAxisOffset + p_CharMargin + _xLabelWidth / 2.0 ;
    
    int y = _chartCavanHeight - (innerGrade * _chartCavanHeight) + (_yLabelHeight / 2) + p_CharMargin - p_CharMargin;
    if (self.showPointLabel) {
        
        UIView *pointLabel = [self viewWithTag:2000];
        [pointLabel removeFromSuperview];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        lable.center = CGPointMake(x, y + 20);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14.0];
        lable.text = [NSString stringWithFormat:@"%.1f",yValue];
        lable.tag = 2000;
        [self addSubview:lable];
    }
    
    [self setNeedsDisplay];
    
}
- (void)strokeChart {
    
    [self calculateChartPath];
    
    UIGraphicsBeginImageContext(self.frame.size);
    
    
    _chartLine = [CAShapeLayer layer];
    _chartLine.lineCap = kCALineCapButt;
    _chartLine.lineJoin = kCALineJoinMiter;
    _chartLine.fillColor = [[UIColor whiteColor] CGColor];
    _chartLine.lineWidth = _chartData.lineWidth;
    _chartLine.strokeEnd = 0.0;
    
    [self.layer addSublayer:_chartLine];

    self.chartLine.strokeColor = [XSFreshGreen CGColor];

    self.chartLine.path = self.chartPath.CGPath;
    
    
    
    
    
    [CATransaction begin];
    [self.chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    self.chartLine.strokeEnd = 1.0;
    
    // 注释之后就没有绘制动画了
    
    [CATransaction commit];
    
    
    for (int i = 0; i < _chartData.itemCount; i++) {
        CAShapeLayer *pointLayer = [CAShapeLayer layer];
        pointLayer.strokeColor = [XSFreshGreen CGColor];
        pointLayer.lineCap = kCALineCapRound;
        pointLayer.lineJoin = kCALineJoinBevel;
        pointLayer.fillColor = nil;
        pointLayer.lineWidth = _chartData.lineWidth;
        pointLayer.path = [self.chartPointArray objectAtIndex:i].CGPath;
        
        float yValue = _chartData.getData(i).y;
        
        if (yValue<10) {
            pointLayer.strokeColor = [XSGreen CGColor];
            pointLayer.fillColor = [XSGreen CGColor];
        }else{
            pointLayer.strokeColor = [XSIndicatorRed CGColor];
            pointLayer.fillColor = [XSIndicatorRed CGColor];
        }
        // 注释之后就没有绘制动画了
        [CATransaction begin];
        [pointLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
        [CATransaction commit];
        [self.layer addSublayer:pointLayer];

    }
    

    UIGraphicsEndImageContext();

    
}
- (void)calculateChartPath {
    
    XSLineChartData *chartData = self.chartData;
    
    CGFloat yValue;
    CGFloat innerGrade;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    NSMutableArray *linePointsArray = [[NSMutableArray alloc] init];
    NSMutableArray *lineStartEndPointsArray = [[NSMutableArray alloc] init];
    int last_x = 0;
    int last_y = 0;
    NSMutableArray<NSDictionary<NSString *, NSValue *> *> *progrssLinePaths = [NSMutableArray new];
    CGFloat inflexionWidth = chartData.inflexionPointWidth;
    
    for (NSUInteger i = 0; i < chartData.itemCount; i++) {
        
        yValue = chartData.getData(i).y;
        
        innerGrade = yValue/20.0;
        
        int x = i * _xLabelWidth + p_YAxisOffset + p_CharMargin + _xLabelWidth / 2.0 ;
        
        int y = _chartCavanHeight - (innerGrade * _chartCavanHeight) - p_CharMargin;
        
       
        UIBezierPath *pointPath = [UIBezierPath bezierPath];

        CGRect circleRect = CGRectMake(x - inflexionWidth / 2, y - inflexionWidth / 2, inflexionWidth, inflexionWidth);
        CGPoint circleCenter = CGPointMake(circleRect.origin.x + (circleRect.size.width / 2), circleRect.origin.y + (circleRect.size.height / 2));
        
        [pointPath moveToPoint:CGPointMake(circleCenter.x + (inflexionWidth / 2), circleCenter.y)];
        [pointPath addArcWithCenter:circleCenter radius:inflexionWidth / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [pointPath closePath];
        
        [self.chartPointArray addObject:pointPath];
        
        
        
        if (i > 0) {
            
            // calculate the point for line
            float distance = sqrt(pow(x - last_x, 2) + pow(y - last_y, 2));
            float last_x1 = last_x + (inflexionWidth / 2) / distance * (x - last_x);
            float last_y1 = last_y + (inflexionWidth / 2) / distance * (y - last_y);
            float x1 = x - (inflexionWidth / 2) / distance * (x - last_x);
            float y1 = y - (inflexionWidth / 2) / distance * (y - last_y);
            
            [progrssLinePaths addObject:@{@"from" : [NSValue valueWithCGPoint:CGPointMake(last_x1, last_y1)],
                                          @"to" : [NSValue valueWithCGPoint:CGPointMake(x1, y1)]}];
        }
        [linePointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        last_x = x;
        last_y = y;
    }
    
    if (self.showSmoothLines && chartData.itemCount >= 4) {
        [progressline moveToPoint:[progrssLinePaths[0][@"from"] CGPointValue]];
        for (NSDictionary<NSString *, NSValue *> *item in progrssLinePaths) {
            CGPoint p1 = [item[@"from"] CGPointValue];
            CGPoint p2 = [item[@"to"] CGPointValue];
            [progressline moveToPoint:p1];
            CGPoint midPoint = [XSLineChart midPointBetweenPoint1:p1 andPoint2:p2];
            [progressline addQuadCurveToPoint:midPoint
                                 controlPoint:[XSLineChart controlPointBetweenPoint1:midPoint andPoint2:p1]];
            [progressline addQuadCurveToPoint:p2
                                 controlPoint:[XSLineChart controlPointBetweenPoint1:midPoint andPoint2:p2]];
        }
    } else {
        for (NSDictionary<NSString *, NSValue *> *item in progrssLinePaths) {
            if (item[@"from"]) {
                [progressline moveToPoint:[item[@"from"] CGPointValue]];
                [lineStartEndPointsArray addObject:item[@"from"]];
            }
            if (item[@"to"]) {
                [progressline addLineToPoint:[item[@"to"] CGPointValue]];
                [lineStartEndPointsArray addObject:item[@"to"]];
            }
        }
    }
    self.chartPath = progressline;
}
- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext(); //使用uikit框架下的方法会自动对坐标系统进行翻转
    CGPoint point;
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    
    
    for (NSUInteger i = 0; i < 5; i++) {
        
        float y = 0.0f;
        
        switch (i) {
            case 0:  /// 10.0
                y = p_CharMargin;
                break;
            case 1:
                y = _chartCavanHeight/2 + p_CharMargin;
                break;
            case 2:
                y = _chartCavanHeight/2 + 3.0/20*_chartCavanHeight + p_CharMargin;
                break;
            case 3:
                y = _chartCavanHeight/2 + 5.6/20*_chartCavanHeight + p_CharMargin;
                break;
            case 4:
                y = _chartCavanHeight + p_CharMargin;
                break;
                
            default:
                break;
        }
        
        point = CGPointMake(p_CharMargin + p_YAxisOffset, y);
        CGContextMoveToPoint(ctx, point.x, point.y);
        // add dotted style grid
        CGFloat dash[] = {6, 5};
        // dot diameter is 20 points
        CGContextSetLineWidth(ctx, 0.5);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineDash(ctx, 0.0, dash, 2);
        CGContextAddLineToPoint(ctx, CGRectGetWidth(rect) - p_CharMargin, point.y);
        CGContextStrokePath(ctx);
    }
    
    [super drawRect:rect];
}
+ (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
}
+ (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    CGPoint controlPoint = [self midPointBetweenPoint1:point1 andPoint2:point2];
    CGFloat diffY = abs((int) (point2.y - controlPoint.y));
    if (point1.y < point2.y)
        controlPoint.y += diffY;
    else if (point1.y > point2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}
- (CABasicAnimation *)fadeAnimation {
    CABasicAnimation *fadeAnimation = nil;
    if (self.displayAnimated) {
        fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
        fadeAnimation.duration = 2.0;
    }
    return fadeAnimation;
}
- (CABasicAnimation *)pathAnimation {
    if (self.displayAnimated && !_pathAnimation) {
        _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _pathAnimation.duration = 1.0;
        _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _pathAnimation.fromValue = @0.0f;
        _pathAnimation.toValue = @1.0f;
    }
    return _pathAnimation;
}
- (void)updateChartData:(XSLineChartData *)data{

    
}

@end
