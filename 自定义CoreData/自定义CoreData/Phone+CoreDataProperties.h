//
//  Phone+CoreDataProperties.h
//  自定义CoreData
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Phone.h"

NS_ASSUME_NONNULL_BEGIN

@interface Phone (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *phoneName;
@property (nullable, nonatomic, retain) NSNumber *phonePrice;

@end

NS_ASSUME_NONNULL_END
