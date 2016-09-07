//
//  Person+CoreDataProperties.h
//  CoreData_03
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *personName;
@property (nullable, nonatomic, retain) NSNumber *personAge;
@property (nullable, nonatomic, retain) NSString *personID;

@end

NS_ASSUME_NONNULL_END
