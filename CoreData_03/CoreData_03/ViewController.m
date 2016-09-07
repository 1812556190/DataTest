//
//  ViewController.m
//  CoreData_03
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Person+CoreDataProperties.h"

@interface ViewController ()

@end

@implementation ViewController



//MagicalRecord使用步骤：
 //:1.初始化
 //2、开始使用
  //3 [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];//禁用日志输出


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    NSLog(@"%@",NSHomeDirectory());
    [self insterObject];
    [self selectObject];
    
}

#pragma mark - 插入数据
- (void)insterObject{
    NSManagedObjectContext *macontext =[NSManagedObjectContext MR_defaultContext];
    
    Person *person = [Person MR_createEntityInContext:macontext];
    person.personID = @"12222221";
    person.personAge = @29;
    person.personName = @"QQhhhwww";
    
    //保存上下文
    [macontext MR_saveToPersistentStoreAndWait];
}


#pragma mark - 查找
- (void)selectObject{
    
    NSArray *object = [Person MR_findAll];//普通查找
    NSArray *object_01 = [Person MR_findAllSortedBy:@"personAge" ascending:NO];//按字段排序查找
    
    [object_01 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Person *person = (Person *)obj;
        NSLog(@"%@ %@",person.personName,person.personAge);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
