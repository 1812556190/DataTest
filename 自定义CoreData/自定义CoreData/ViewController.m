//
//  ViewController.m
//  自定义CoreData
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"
#import "XSCoreDataManger.h"
#import "Student+CoreDataProperties.h"
#import "Book+CoreDataProperties.h"
#import "Phone+CoreDataProperties.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    
    [self insterObject];
//    [self selectObjct];
    
}


- (void)selectObjct{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    NSArray *object =  [[XSCoreDataManger shareManger].manageContext executeFetchRequest:request error:nil];
    [object enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Student *stu = (Student *)obj;
        NSLog(@"%@ %@ %@  %@ %@",stu.stuName, stu.stuAge,stu.stuID,stu.book.bookName,stu.book.bookPrice);
        for (Phone *phone in stu.phone) {
            NSLog(@"%@ %@",phone.phoneName,phone.phonePrice);
        }
    }];
    
    
}


- (void)insterObject{
     Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:[XSCoreDataManger shareManger].manageContext];
    book.bookName = @"中华上下五千年";
    book.bookPrice = @66.9;
    
   
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (NSInteger i = 1; i < 5; i++) {
         Phone *phone = [NSEntityDescription insertNewObjectForEntityForName:@"Phone" inManagedObjectContext:[XSCoreDataManger shareManger].manageContext];
        phone.phoneName = [NSString stringWithFormat:@"phone_%ld",i];
        phone.phonePrice = @20.0;
        [set addObject:phone];
    }
    NSLog(@"-----%@",set);
    
    
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:[XSCoreDataManger shareManger].manageContext];
    stu.stuID = @"100004";
    stu.stuAge = @20;
    stu.stuName =@"妈的智障";
    stu.book = book;
    stu.phone = set;
    [[XSCoreDataManger shareManger] saveContext];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
