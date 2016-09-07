//
//  Book+CoreDataProperties.h
//  CoreData的使用
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 Lingser. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bookName;
@property (nullable, nonatomic, retain) NSNumber *bookPrice;
@property (nullable, nonatomic, retain) NSString *bookAuthor;

@end

NS_ASSUME_NONNULL_END
