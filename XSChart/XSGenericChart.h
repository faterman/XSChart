//
//  XSGenericChart.h
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XSGenericChart : UIView
/// 是否以动画的形式展示
@property (nonatomic) BOOL displayAnimated;

///初始化方法
- (void) setupDefaultValues;
@end
