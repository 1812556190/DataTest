//
//  ViewController.m
//  网络断点续传
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>{
    NSURLSessionDownloadTask *_downLoadTask;
    NSData *_resumeData;
    NSInteger _loadLenth;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progarssView;
@property (weak, nonatomic) IBOutlet UILabel *progassText;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *puasuBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) NSURLSession *sesson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loadLenth = 0;
    self.puasuBtn.enabled = NO;
    self.cancelBtn.enabled = NO;
    
    NSLog(@"%@",NSHomeDirectory());
    
    
}


- (NSURLSession *)sesson{
    if (!_sesson) {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        _sesson = session;
    }
    return _sesson;
}


//开始下载
- (void)startDownLoad{
    
    NSString *strUrl = @"http://dzs.qisuu.com/txt/%E7%A9%BF%E8%B6%8A%E4%B9%8B%E8%8B%B1%E9%9B%84%E8%81%94%E7%9B%9F%E7%B3%BB%E7%BB%9F.txt";
    NSURL *url = [NSURL URLWithString:strUrl];
    
    _downLoadTask = [self.sesson downloadTaskWithURL:url];
    
    [_downLoadTask resume];
    
    
}
//暂停下载
- (void)suspendDownLoad{
    
    NSLog(@"暂停下载---");
    self.progassText.text = @"下载已暂停！";
    [_downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData){
        //  resumeData : 包含了继续下载的开始位置\下载的url
        _resumeData = resumeData;
        _downLoadTask = nil;
    }];
}
//继续下载
- (void)resumeDownLoad{
     NSLog(@"继续下载---");
    _downLoadTask  = [self.sesson downloadTaskWithResumeData:_resumeData];
    [_downLoadTask resume];
    _resumeData = nil;
}




#pragma mark  - <NSURLSessionDownloadDelegate>

//下载完成时调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSURL *fileUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    fileUrl = [fileUrl URLByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:fileUrl error:&error];
    if (error) {
        NSLog(@"%@",error);
    }else{
        NSLog(@"下载完成！");
    }
    self.imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:nil]];
    
}
//下载的进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    if (totalBytesExpectedToWrite > _loadLenth) {
        _loadLenth = totalBytesExpectedToWrite;
    }
    
    
    CGFloat progass = (CGFloat)totalBytesWritten / _loadLenth;
    NSString *str = @"%";
    self.progassText.text = [NSString stringWithFormat:@"%.2f %@",progass * 100,str];
    [self.progarssView setProgress:progass animated:YES];
    
    if (progass == 1) {
        self.progassText.text = @"下载完成！";
        self.view.userInteractionEnabled = NO;
    }
}



//取消下载
- (IBAction)btnCanceLoad:(UIButton *)sender {
    
    self.progassText.text = @"下载已取消！";
    [_downLoadTask cancel];
    self.progarssView.progress = 0;
    _resumeData = nil;
    self.puasuBtn.enabled = NO;
    [self.puasuBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
    
    
    self.startBtn.enabled = YES;
    sender.enabled = NO;
    
    
    
    
}


//开始下载
- (IBAction)btnStata:(UIButton *)sender {
   
    
    [self startDownLoad];//开始下载
    
    self.cancelBtn.enabled = YES;
    self.puasuBtn.enabled = YES;
    sender.enabled = NO;//开始下载后就禁止点击
}

//暂停/继续下载
- (IBAction)btnChangeDown:(UIButton *)sender {
    
    if (_resumeData == nil) {
        [self suspendDownLoad];//暂停下载
        [sender setTitle:@"继续下载" forState:UIControlStateNormal];
    }else{
        [self resumeDownLoad];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
}



@end
