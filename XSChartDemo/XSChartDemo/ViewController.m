//
//  ViewController.m
//  XSChartDemo
//
//  Created by faterman on 17/1/17.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "ViewController.h"
#import "XSChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XSLineChart * lineChart = [[XSLineChart alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200.0)];
    [lineChart setXLabels:@[@"12/1",@"12/2",@"12/3",@"12/4",@"12/5"]];
    NSArray * dataArray = @[@5.1, @3.1, @6.4, @7.2, @10.2];
    XSLineChartData *data = [XSLineChartData new];
    data.itemCount = lineChart.xLabels.count;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [XSLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.showSmoothLines = YES;
    lineChart.chartData = data;
    [lineChart strokeChart];
    
    
    [self.view addSubview:lineChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
