//
//  Student+CoreDataProperties.h
//  自定义CoreData
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *stuName;
@property (nullable, nonatomic, retain) NSString *stuID;
@property (nullable, nonatomic, retain) NSNumber *stuAge;
@property (nullable, nonatomic, retain) Book *book;
@property (nullable, nonatomic, retain) NSSet<Phone *> *phone;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addPhoneObject:(Phone *)value;
- (void)removePhoneObject:(Phone *)value;
- (void)addPhone:(NSSet<Phone *> *)values;
- (void)removePhone:(NSSet<Phone *> *)values;

@end

NS_ASSUME_NONNULL_END
