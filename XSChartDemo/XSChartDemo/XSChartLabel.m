//
//  XSChartLabel.m
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSChartLabel.h"

@implementation XSChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.font                      = [UIFont boldSystemFontOfSize:11.0f];
        self.backgroundColor           = [UIColor clearColor];
        self.textAlignment             = NSTextAlignmentCenter;
        self.userInteractionEnabled    = YES;
        self.adjustsFontSizeToFitWidth = YES;
        self.numberOfLines             = 0;
    }
    
    return self;
}

@end
