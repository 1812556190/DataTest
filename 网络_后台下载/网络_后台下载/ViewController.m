//
//  ViewController.m
//  网络_后台下载
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self backDownLoad];
}


#pragma mark -
- (void)backDownLoad{
    NSURL *url = [NSURL URLWithString:@"https://github.com/fuqinglin/MagicalRecord/archive/master.zip"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.tens.www"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downLoad = [session downloadTaskWithURL:url];
    
    [downLoad resume];
    
    
}


#pragma mark - <NSURLSessionDownloadDelegate>

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"下载完成！");
}

//下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"--------");
    
}

//后台下载调用
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    NSLog(@"---下载完成！");
    
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    
    //回调 AppDelegate 中 application: handleEventsForBackgroundURLSession: completionHandler: 中的block事件，处理下载完后的提示
    if (appdelegate.backSessionComple) {
        void(^backBlock)() = appdelegate.backSessionComple;//回调
        
        backBlock();//调用block
    }
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
