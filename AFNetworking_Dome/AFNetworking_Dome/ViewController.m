//
//  ViewController.m
//  AFNetworking_Dome
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    [self afnetworking_Reachability];
}

#pragma mark - 网络监测
- (void)afnetworking_Reachability{
    // 1、监听网络的改变
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
     // 2、网络改变后调用的方法，可以检测到不同类型的网络。
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"为止网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝移动网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self aFN_DownLoad];
                NSLog(@"wifi网络");
                break;
                
            default:
                break;
        }
        
    }];
    
    
}


#pragma mark -  上传文件
- (void)aFN_UpLoad{
    NSURL *url = [NSURL URLWithString:@""];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionUploadTask *upLoad =  [manger uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [upLoad resume];
    
}



#pragma mark - 使用POST方式上传
- (void)aFN_POST_UpLoad{
    
    NSString *strUrl = @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    
     // 1、设置响应返回的数据的类型 [AFHTTPResponseSerializer serializer] 表示以NSData类型返回。 默认是 JSON 格式
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *sessionTask =  [manger POST:strUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@""], 1);
        // 2、拼接要上传的数据并且设置名称、指明数据的类型(image/jpeg)\(video/mp3)
        [formData appendPartWithFileData:imageData name:@"imageName" fileName:@"image" mimeType:@"image/jpeg"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%lld %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *object = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"-----%@",object);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    [sessionTask resume];
    
}


#pragma mark -AFN下载
- (void)aFN_DownLoad{
    NSURL *url = [NSURL URLWithString:@"https://github.com/fuqinglin/MagicalRecord/archive/master.zip"];
   
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    NSURLSessionDownloadTask *downTask =  [manger downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%lld %lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *fileUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        fileUrl = [fileUrl URLByAppendingPathComponent:response.suggestedFilename];
        NSError *error = nil;
        [[NSFileManager defaultManager] moveItemAtURL:targetPath toURL:fileUrl error:&error];
        if (error) {
            NSLog(@"%@",error);
        }else{
            
        }
        return fileUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
    
    [downTask resume];
}


#pragma mark - get请求
- (void)aFN_GET{
    
    NSString *strUrl = @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *dataTask =  [manger GET:strUrl parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    [dataTask resume];
    
}

#pragma mark - post请求
- (void)aFN_POST{
    NSString *strUrl = @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:strUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}




@end
