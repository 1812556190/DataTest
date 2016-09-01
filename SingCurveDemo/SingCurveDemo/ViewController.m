//
//  ViewController.m
//  SingCurveDemo
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import "SingCurve.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SingCurve *singView = [[SingCurve alloc] initWithFrame:self.view.frame];
    singView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:singView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
