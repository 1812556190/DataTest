//
//  ViewController.m
//  数据持久化--归档
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    
//    [self archive];
//    [self customArchive];
}
- (void)archive{
    
    NSArray *array = @[@1,@2,@3];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"info.xiangsen"];
    //归档
   BOOL isArchiver =  [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    if (isArchiver) {
        NSLog(@"归档成功！%@",documentPath);
    }else{
        NSLog(@"归档失败！");
    }
    
    //解档
    NSArray *array_01 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"-------%@",array_01);
    
    
}

//自定义解归档---必须实现NSCoding协议
- (void)customArchive{
    User *user = [[User alloc] init];
    user.userName = @"0000";
    user.passWord = @"11111111";
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"info_2.xiangsen"];
    //归档
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
    
    //解档
    User *user_01 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"//////%@",user_01.userName);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
