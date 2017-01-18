//
//  XSAutorotateNavigationBar.m
//  XSChartDemo
//
//  Created by faterman on 17/1/18.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSAutorotateNavigationBar.h"

@implementation XSAutorotateNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        UINavigationBar *nav = [[UINavigationBar alloc]initWithFrame:frame];
        [self addSubview:nav];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 60, 0, 40, 40)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(shrinkFullScreen) forControlEvents:UIControlEventTouchUpInside];
                
    }
    return self;
}

- (void)shrinkFullScreen {

    [self.delegate rightItemClick];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
