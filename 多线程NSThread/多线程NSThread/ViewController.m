//
//  ViewController.m
//  多线程NSThread
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //当前线程[NSThread currentThread];
    NSLog(@"%@",[NSThread currentThread]);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //创建一个线程
    NSThread *thread_A = [[NSThread alloc] initWithTarget:self selector:@selector(run_A) object:nil];
     NSThread *thread_B = [[NSThread alloc] initWithTarget:self selector:@selector(run_B) object:nil];
     NSThread *thread_C = [[NSThread alloc] initWithTarget:self selector:@selector(run_C) object:nil];
     NSThread *thread_D = [[NSThread alloc] initWithTarget:self selector:@selector(run_D) object:nil];
    
    //阻塞所有线程多少秒
    [NSThread sleepForTimeInterval:5];
    //阻塞所有线程到多少时间
    [NSThread sleepUntilDate:[[NSDate date] dateByAddingTimeInterval:1000] ];
    
    
    [thread_A start];
    [thread_B start];
    [thread_C start];
    [thread_D start];
    
    
    
}


- (void)run_A{

}
- (void)run_B{
    
}
- (void)run_C{
    
}
- (void)run_D{
    
}


@end
