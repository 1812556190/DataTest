//
//  User.h
//  数据持久化--归档
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>


@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *passWord;

@end
