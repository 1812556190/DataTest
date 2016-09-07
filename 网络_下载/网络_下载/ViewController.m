//
//  ViewController.m
//  网络_下载
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#define XSSREENWIDTH [UIScreen mainScreen].bounds.size.width
#define XSSREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>


@property (nonatomic, strong)UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.progressView];
//    [self downLoad];//下载
    
//    [self upDataLoad_Block];
    [self upLoad_delegate];
    
}

#pragma mark - 代理方式上传

- (void)upLoad_delegate{
    NSString *strUrl = @"http://www.imageshack.us/index.php";
    
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"image4.jpg"], 0.5);
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    
    [request setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionUploadTask *upLoadTask = [session uploadTaskWithRequest:request fromData:data];

    [upLoadTask resume];

    
}


#pragma mark - <NSURLSessionDataDelegate>

//上传完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler{
    NSLog(@"上传完成！");
}


//上传的进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    
    CGFloat prograss = (CGFloat)totalBytesSent /totalBytesExpectedToSend;
    [self.progressView setProgress:prograss animated:YES];
    
    
}

//上传错时调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    NSLog(@"%@",error);
}


#pragma mark - 文件上传block方式
- (void)upDataLoad_Block{
//    NSString *strType = @"image/jpg";
//    NSString *imageName = @"image4.jpg";
//    NSString *boundary = @"HEHE";//设置分隔符
//    NSMutableData *data = [NSMutableData data];
//    
//    //设置头部
//    NSString *strTop = [NSString stringWithFormat:@"--%@\nContent-Disposition: form-data; name=\"file1\"; filename=\"%@\"\nContent-Type: %@\n\n",boundary,imageName,strType];
//    //设置尾部
//    NSString *strBottom = [NSString stringWithFormat:@"\n--%@--",boundary];
//    
//    //将图片路径转成Data
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
//    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//    
//    //将所有数据拼接成Data
//    [data appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
//    [data appendData:fileData];
//    [data appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *strUrl = @"http://www.imageshack.us/index.php";

    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"image4.jpg"], 0.5);
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    
    [request setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *upLoad = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (!error) {
            NSString *dataStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@ 上传成功！",dataStr);
        }else{
            NSLog(@"error is :%@",error.localizedDescription);
        }
        
    }];
    
    
    [upLoad resume];
 
    
}





#pragma mark - 下载文件
- (void)downLoad{
    NSString *strUrl = @"https://github.com/1812556190/AFNetworking/archive/master.zip";
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downSession = [session downloadTaskWithURL:url];
    
    //启动任务
    [downSession resume];
    
}

#pragma mark -<NSURLSessionDownloadDelegate>

//下载完成后调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"下载完成!%@",NSHomeDirectory());
    
     NSURL *documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *fileUrl = [documentURL URLByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:fileUrl error:&error];
    if (!error) {
        NSLog(@"文件保存成功！");
    }else{
        NSLog(@"%@",error);
    }
    
    
}
//下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    CGFloat progress = (CGFloat)totalBytesWritten / totalBytesExpectedToWrite;
    
    [self.progressView setProgress:progress animated:YES];
    
    NSLog(@"%f",self.progressView.progress);
    
    
}




#pragma mark - 懒加载进度条视图
- (UIProgressView *)progressView{
    if (!_progressView) {
        UIProgressView *progressView= [[UIProgressView alloc] init];
        progressView.frame = CGRectMake(20,100, XSSREENWIDTH - 40, 0);
        progressView.progressTintColor = [UIColor redColor];
        progressView.tintColor = [UIColor whiteColor];
        progressView.progress = 0.0;
        _progressView = progressView;
    }
    return _progressView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
