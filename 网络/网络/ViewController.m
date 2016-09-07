//
//  ViewController.m
//  网络
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
//    [self sessionTask_GET];
//    [self sessionTask_POST];
    [self sessionTask_Configuration];
}

#pragma mark - 网络配置

- (void)sessionTask_Configuration{
    
    NSString *strUrl = @"https://route.showapi.com/213-4?showapi_appid=24060&showapi_timestamp=20160905145715&topid=5&showapi_sign=37bb17d01d1fb9ba0525c8b0572f161f";
    //创建URL
    NSURL *url = [NSURL URLWithString:strUrl];
    //创建请求并设置缓存策略
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建NSURLSession 并配置网络缓存
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;//可以设置缓存策略
    
    //请求数据
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonData);
        
    }];
    //开始执行网路任务
    [sessionTask resume];
    
}


#pragma mark - 创建get请求

- (void)sessionTask_GET{
    
    NSString *strUrl = @"https://route.showapi.com/213-4?showapi_appid=24060&showapi_timestamp=20160905145715&topid=5&showapi_sign=37bb17d01d1fb9ba0525c8b0572f161f";
    //创建URL
    NSURL *url = [NSURL URLWithString:strUrl];
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //创建
    NSURLSession *session = [NSURLSession sharedSession];
    
    //请求数据
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonData);
        
    }];
    //开始执行网路任务
    [sessionTask resume];
    
    
}

#pragma mark - 创建POST请求
- (void)sessionTask_POST{
    NSString *strUrl = @"https://route.showapi.com/213-4";
    //创建URL
    NSURL *url = [NSURL URLWithString:strUrl];
    
    //创建可变请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //指定请求方式
    [request setHTTPMethod:@"POST"];
    
    //指定请求体
    NSString *strBody = @"showapi_appid=24060&showapi_timestamp=20160905145715&topid=5&showapi_sign=37bb17d01d1fb9ba0525c8b0572f161f";
    [request setHTTPBody:[strBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //请求数据
    NSURLSessionDataTask *session_task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonData);
        
    }];
    
    //开始请求任务
    [session_task resume];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
