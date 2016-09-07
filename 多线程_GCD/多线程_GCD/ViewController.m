//
//  ViewController.m
//  多线程_GCD
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewThere;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnLoadAction:(UIButton *)sender {
   
    //全局队列 并行队列
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self run_A];
     });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self run_B];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self run_C];
    });

   
    
}

//在主队列中执行异步任务
- (void)mainAsync{
    
    dispatch_async(dispatch_get_main_queue(), ^{//异步任务
        self.imageViewOne.image = [self deloadOneImage];
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(dispatch_get_main_queue(), ^{//异步任务
        self.imageViewTwo.image = [self deloadTwoImage];
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(dispatch_get_main_queue(), ^{//异步任务
        self.imageViewThere.image = [self deloadThereImage];
        NSLog(@"%@",[NSThread currentThread]);
    });
}
#pragma mark - 
- (void)GCD_One{
    //只会执行一次blcok里面的代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

#pragma mark - 延迟调用

- (void)GCD_after{
    
    //延迟调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
}



#pragma mark - group
- (void)GCD_group{
   __block UIImage *image_01;
   __block UIImage *image_02;
   __block UIImage *image_03;
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    
    //3.在队列组类异步执行任务
    dispatch_group_async(group, queue, ^{
        image_01 = [self deloadOneImage];
    });
    dispatch_group_async(group, global, ^{
        image_02 = [self deloadTwoImage];
    });
    dispatch_group_async(group, queue, ^{
        image_03 = [self deloadThereImage];
    });
    
    //4、当队列组内的所有任务都完成后，就会发送一个通知notify 执行这个方法
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.imageViewOne.image = image_01;
        self.imageViewTwo.image = image_02;
        self.imageViewThere.image = image_03;
    });
}



- (void)gcdModefil{
    
    //获取主队列 dispatch_get_main_queue()
    dispatch_sync(dispatch_get_main_queue(), ^{//同步任务
        
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{//异步任务
        self.imageViewOne.image = [self deloadOneImage];
        
    });
    
    //获取全局队列 dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    //DISPATCH_QUEUE_PRIORITY_DEFAULT 优先级
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
    
    //自定义队列
    dispatch_queue_t serialQueue = dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    
}


- (void)run_A{
     // 将更新UI的操作放到主队列中
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageViewOne.image = [self deloadOneImage];
    });
    
   
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)run_B{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageViewTwo.image = [self deloadTwoImage];
    });
    
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)run_C{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageViewThere.image = [self deloadThereImage];
    });
    
    NSLog(@"%@",[NSThread currentThread]);
}


- (UIImage *)deloadOneImage{
    NSURL *url = [NSURL URLWithString:@"http://img.ivsky.com/img/tupian/pre/201507/01/yindian_meinv-001.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
  
    return  [UIImage imageWithData:data];
}
- (UIImage *)deloadTwoImage{
    NSURL *url = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/h%3D360/sign=634e643dcafcc3ceabc0cf35a244d6b7/cefc1e178a82b9016ece2b2c718da9773912ef4a.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    return  [UIImage imageWithData:data];
}
- (UIImage *)deloadThereImage{
    NSURL *url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/h%3D360/sign=b9a4961ad71b0ef473e89e58edc451a1/b151f8198618367ac7d2a1e92b738bd4b31ce5af.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    return  [UIImage imageWithData:data];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
