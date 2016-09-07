//
//  ViewController.m
//  FMDB_demo
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import <FMDB.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"datas_02.sqlite"];
    //1.创建一个FMDatabaseQueue对象
     //2、使用 inDatabase:时无需再进行打开数据库操作
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    [queue inDatabase:^(FMDatabase *db) {
        //写执行代码
     
    }];
    
    
}



//创建表
- (void)createTable:(FMDatabase *)db{
    NSString *sql = @"create table if not exists User('userID'text,'userName'text,'userAge'integer)";
    BOOL isSucces =  [db executeUpdate:sql];
    if (isSucces) {
        NSLog(@"创建表成功！");
    }else{
        NSLog(@"创建表失败！");
    }
}



//非多线程下
- (void)dataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"datas.sqlite"];
    FMDatabase *dataSql = [FMDatabase databaseWithPath:filePath];
    if (![dataSql open]) {
        NSLog(@"数据库打开失败！");
        return;
    }
    NSString *sql = @"create table if not exists User('userID'text,'userName'text,'userAge'integer)";
    //    [dataSql executeUpdate:sql];
    NSString *sql_01 = @"insert into User('userID','userName','userAge')values('10001','疾风剑豪',20)";
    
    [dataSql executeUpdate:sql_01];
    
    
    NSLog(@"%@",documentPath);
    
    
    FMResultSet *resuSet = [dataSql executeQuery:@"select *from User where userAge = 10001"];
    while ([resuSet next]) {
        
        int age = [resuSet intForColumn:@"userAge"];
        NSString *str = [resuSet stringForColumn:@"userName"];
        NSLog(@"%d %@",age,str);
    }
    
    [dataSql close];//关闭数据库
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
