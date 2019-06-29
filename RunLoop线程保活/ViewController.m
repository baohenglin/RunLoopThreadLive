//
//  ViewController.m
//  RunLoop线程保活
//
//  Created by BaoHenglin on 2019/6/28.
//  Copyright © 2019 BaoHenglin. All rights reserved.
//

#import "ViewController.h"
#import "HLPermenantThread.h"
@interface ViewController ()
@property (nonatomic, strong) HLPermenantThread *permenantThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.permenantThread = [[HLPermenantThread alloc]init];
    [self.permenantThread run];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.permenantThread executeTask:^{
        NSLog(@"执行任务:%s %@",__func__,[NSThread currentThread]);
    }];
}

- (IBAction)stopBtnClick:(id)sender {
    [self.permenantThread stop];
}
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
