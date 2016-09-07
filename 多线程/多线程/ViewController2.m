//
//  ViewController2.m
//  多线程
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController2.h"
#import "OneController.h"

@interface ViewController2 ()

@property (strong, nonatomic)OneController *oneVc;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.oneVc = [[OneController alloc] init];
    
//    self.oneVc.block = ^{
//        [self test];
//    };
//    
    [self.oneVc testBlock:^{
        [self test];
    }];
//
    [self.navigationController pushViewController:self.oneVc animated:YES];
}

- (void)test {
    NSLog(@"123");
}


- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
