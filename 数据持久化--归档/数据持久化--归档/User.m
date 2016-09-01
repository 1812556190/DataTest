//
//  User.m
//  数据持久化--归档
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "User.h"

@implementation User

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
}

//解归档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.userName = [aDecoder decodeObjectForKey:@"userName"]
        ;
        self.passWord = [aDecoder decodeObjectForKey:@"passWord"];
    }
    return self;
}




@end
