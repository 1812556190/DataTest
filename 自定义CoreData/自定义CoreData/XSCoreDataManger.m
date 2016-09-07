//
//  XSCoreDataManger.m
//  自定义CoreData
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "XSCoreDataManger.h"

@interface XSCoreDataManger ()

@property (nonatomic, strong) NSManagedObjectModel *manageModel;

@property (nonatomic, strong) NSPersistentStoreCoordinator *manageCoordintor;

@property (nonatomic, strong) NSURL *dbUrl;
@end

static XSCoreDataManger *coreManger = nil;
@implementation XSCoreDataManger


#pragma mark - 单例
+ (instancetype)shareManger{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreManger = [[self alloc] init];
    });
    
    return coreManger;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (coreManger == nil) {
        coreManger = [super allocWithZone:zone];
    }
    return coreManger;
}


#pragma mark - 加载模型文件

- (NSManagedObjectModel *)manageModel{
    if (_manageModel != nil) {
        return _manageModel;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _manageModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _manageModel;
}

#pragma mark - 创建数据库保存的本地URL
- (NSURL *)dbUrl{
    if (_dbUrl != nil) {
        return  _dbUrl;
    }
    
    _dbUrl = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"db.sqlite"];
    return _dbUrl;
    
}

#pragma mark - 创建持久化调度者

- (NSPersistentStoreCoordinator *)manageCoordintor{
    if (_manageCoordintor != nil ) {
        return _manageCoordintor;
    }
     // 1、创建并加载 模型文件
    _manageCoordintor = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.manageModel];
    
    NSDictionary *option = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption: @YES};
    NSError *error;
    // 2、设置持久化文件类型、配置并设置 持久化文件的URL
    [_manageCoordintor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.dbUrl options:option error:&error];
    if (error) {
        NSLog(@"error: %@",error);
    }
    return _manageCoordintor;
}

#pragma mark - 创建上下文

- (NSManagedObjectContext *)manageContext{
    if (_manageContext != nil) {
        return _manageContext;
    }
    
     // 1、创建并设置所在的线程队列： NSMainQueueConcurrencyType
    _manageContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    // 2、指定上下文的持久化调度者
    _manageContext.persistentStoreCoordinator = self.manageCoordintor;
    
    return _manageContext;
}


#pragma mark - 保存上下文
- (void)saveContext{
    NSError *error;
    if ([self.manageContext hasChanges] && [self.manageContext save:&error]) {
        NSLog(@"保存成功！");
    }else{
        NSLog(@"error: %@",error);
    }
}



@end
