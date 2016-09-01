//
//  ViewController.m
//  数据持久化--属性列表
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
    
    NSLog(@"%@",NSHomeDirectory());
//    [self propertyPlist];
    [self userDefaults];
    
}

- (void)propertyPlist{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    [userInfo setObject:@"把智障" forKey:@"name"];
    [userInfo setObject:@100 forKey:@"age"];
    [userInfo setObject:@1.23 forKey:@"hight"];
    
   BOOL isWrite = [userInfo writeToFile:filePath atomically:YES];//将字典写入到plist文件
    if (isWrite) {
        NSLog(@"写入成功!%@",docPath);
    }else{
        NSLog(@"写入失败！");
    }
  
}
//用户偏好设置
- (void)userDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//单例
    
    [defaults setObject:@"zhhhh" forKey:@"name"];//写入
    [defaults synchronize];//数据同步
    
    id obj =  [defaults objectForKey:@"name"];
    NSLog(@"%@",obj);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
