//
//  ViewController.m
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "ViewController.h"
#import "XSChart.h"
#import "XSAutorotateNavigationBar.h"
@interface ViewController ()<XSAutorotateNavigationBarDelegate>
{
    BOOL _isLandscape;
}
@property(nonatomic) UIDeviceOrientation orientation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    self.orientation = UIDeviceOrientationPortrait;
    [self portraitLayout];
}
- (IBAction)fullScreen:(id)sender {
    
    
    if (!_isLandscape) {
        
        if (self.orientation == UIDeviceOrientationPortrait || self.orientation == UIDeviceOrientationFaceUp || self.orientation == UIDeviceOrientationFaceDown) {
        
            self.orientation = UIDeviceOrientationLandscapeLeft;
        }
  
        _isLandscape = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
        [self.navigationController.navigationBar setHidden:YES];
        [self orientationChange];

    }else {
        
        if (self.orientation != UIDeviceOrientationPortrait) {
            self.orientation = UIDeviceOrientationPortrait;
        }
        
        _isLandscape = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
        [self.navigationController.navigationBar setHidden:NO];
        [self orientationChange];

    }
    
    
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (void)deviceOrientationDidChange
{
    NSLog(@"deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    self.orientation = [UIDevice currentDevice].orientation;
}

- (void)orientationChange
{
    if (self.orientation == UIDeviceOrientationLandscapeLeft) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
        }];
        
        [self landScapeLayout];
        
    }else if (self.orientation == UIDeviceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
            self.view.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
        }];
        [self landScapeLayout];

    }else {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        [self portraitLayout];
    }
}

- (void)portraitLayout {
    
    for (UIView * subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    
    XSLineChart * lineChart = [[XSLineChart alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200.0)];
    [lineChart setXLabels:@[@"12/1",@"12/2",@"12/3",@"12/4",@"12/5"]];
    NSArray * dataArray = @[@2, @10.2, @1.3, @7.6, @2];
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
    [self.view addSubview:lineChart];

}


- (void)landScapeLayout {
    
    for (UIView * subView in self.view.subviews) {
        [subView removeFromSuperview];
    }

    XSAutorotateNavigationBar *navigationBar = [[XSAutorotateNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 44)];
    navigationBar.delegate = self;
    [self.view addSubview:navigationBar];
    
    
    XSLineChart * lineChart = [[XSLineChart alloc] initWithFrame:CGRectMake(0, 44, SCREEN_HEIGHT, SCREEN_WIDTH-44)];
    [lineChart setXLabels:@[@"12/1",@"12/2",@"12/3",@"12/4",@"12/5"]];
    NSArray * dataArray = @[@2, @8, @1.3, @7.6, @2];
    XSLineChartData *data = [XSLineChartData new];
    data.itemCount = lineChart.xLabels.count;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [XSLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.showPointLabel = YES;
    lineChart.showSmoothLines = YES;
    lineChart.chartData = data;
    [lineChart strokeChart];
    [self.view addSubview:lineChart];

}
-(void)rightItemClick{

    [self fullScreen:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
