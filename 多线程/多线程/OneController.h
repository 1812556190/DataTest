//
//  OneController.h
//  多线程
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TestBlock)();

@interface OneController : UIViewController

@property (copy, nonatomic) TestBlock block;

- (void)testBlock:(TestBlock)block;

@end
