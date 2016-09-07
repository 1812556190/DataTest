//
//  User+CoreDataProperties.h
//  CoreData的使用
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSNumber *userAge;

@end

NS_ASSUME_NONNULL_END
