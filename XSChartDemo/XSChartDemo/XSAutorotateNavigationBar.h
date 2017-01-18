//
//  XSAutorotateNavigationBar.h
//  XSChartDemo
//
//  Created by faterman on 17/1/18.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XSAutorotateNavigationBarDelegate <NSObject>

- (void)rightItemClick;

@end

@interface XSAutorotateNavigationBar : UIView
@property (weak, nonatomic) id<XSAutorotateNavigationBarDelegate>delegate;
@end
