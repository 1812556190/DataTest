//
//  XSCoreDataManger.h
//  自定义CoreData
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface XSCoreDataManger : NSObject

/**
 *  管理上下文
 */
@property (nonatomic, strong) NSManagedObjectContext *manageContext;


+ (instancetype)shareManger;

//保存上下文
- (void)saveContext;

@end
