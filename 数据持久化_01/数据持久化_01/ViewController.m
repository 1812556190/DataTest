//
//  ViewController.m
//  数据持久化_01
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   /*
    //获取当前app的目录
    NSString *pathFile = NSHomeDirectory();
    
    NSString *documentPath = [pathFile stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",pathFile);
    NSLog(@"%@",[self docfile]);
    NSLog(@"%@",[self libfile]);
    NSLog(@"%@",[self cachesfile]);
    NSLog(@"%@",[self temPath]);
    */
//    [self creatFolder];
//    NSLog(@"%@",[self docfile]);
//    [self creatFile];
//    [self moveFile];
    [self removeFile];
    
    
}

//创建文件夹
- (void)creatFolder{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self docfile] stringByAppendingPathComponent:@"XSDou"];
    NSError *error = nil;
   BOOL isCreat = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
    if (isCreat) {
        NSLog(@"创建成功！%@",filePath);
    }else{
        NSLog(@"创建失败！%@",error);
    }
}
//创建文件
- (void)creatFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self docfile] stringByAppendingPathComponent:@"XSDou/info.txt"];
    NSString *text = @"八区二哈诗歌智障加脑残";
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    BOOL isCreat =  [fileManager createFileAtPath:filePath contents:data attributes:nil];
    if (isCreat) {
        NSLog(@"创建成功！%@",[self docfile]);
    }else{
        NSLog(@"创建失败！");
    }
}

//移动文件
- (void)moveFile{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *filePath = [[self docfile] stringByAppendingPathComponent:@"XSDou/info.txt"];
    NSString *newFilePath = [[self libfile] stringByAppendingPathComponent:@"xs.txt"];
    NSError *error = nil;
    BOOL isMoveFile = [fileManger moveItemAtPath:filePath toPath:newFilePath error:&error];
    if (isMoveFile) {
        NSLog(@"移动成功！%@",[self docfile]);
    }else{
        NSLog(@"移动失败！");
    }
}

//删除文件
- (void)removeFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self docfile] stringByAppendingPathComponent:@"XSDou"];
    NSError *error = nil;
    BOOL isCreat = [fileManager removeItemAtPath:filePath error:&error];
    if (isCreat) {
        NSLog(@"移除成功！%@",[self docfile]);
    }else{
        NSLog(@"移除失败！%@",error);
    }
}


//获取Documents目录
- (NSString *)docfile{
    
    
    /**
     *  NSSearchPathForDirectoriesInDomains(NSDocumenDirectory, NSUserDomainMask, YES) lastObject];
     *
     *  第一个参数： 要获取的目录名称
     *  第二个参数： 要查找的目录的主目录(沙盒目录)  NSUserDomainMask
     *  第三个参数   是否返回完整的目录
     *
     *
     */
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

//获取Library目录
- (NSString *)libfile{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

//获取缓存目录Caches
- (NSString *)cachesfile{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//获取临时文件目录
- (NSString *)temPath{
    return NSTemporaryDirectory();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
