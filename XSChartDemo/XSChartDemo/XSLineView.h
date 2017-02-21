//
//  XSLineView.h
//  XSChartDemo
//
//  Created by faterman on 17/2/16.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSLineView : UIView
@property (nonatomic) CGFloat chartCavanHeight;
@property (nonatomic) CGFloat yLabelHeight;
- (instancetype)initWithFrame:(CGRect)frame XLabels:(NSArray *)xLabels DataArray:(NSArray *)dataArray;
@end
