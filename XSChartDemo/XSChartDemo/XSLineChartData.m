//
//  XSLineChartData.m
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSLineChartData.h"

@implementation XSLineChartData
- (id)init
{
    self = [super init];
    if (self) {
        [self setupDefaultValues];
    }
    
    return self;
}

- (void)setupDefaultValues
{
    _inflexionPointWidth = 4.f;
    _lineWidth = 1.f;
    _alpha = 1.f;
    _showPointLabel = NO;
    _pointLabelColor = [UIColor blackColor];
    _pointLabelFormat = @"%1.f";
}
@end
