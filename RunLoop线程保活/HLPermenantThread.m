//
//  HLPermenantThread.m
//  RunLoop线程保活封装
//
//  Created by BaoHenglin on 2019/6/29.
//  Copyright © 2019 BaoHenglin. All rights reserved.
//

#import "HLPermenantThread.h"

@interface HLThread : NSThread
@end

@implementation HLThread
- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end


@interface HLPermenantThread ()
@property (nonatomic, strong) HLThread *innerThread;
//@property (nonatomic, strong) NSThread *innerThread;
@property (nonatomic, assign, getter=isStopped) BOOL isStopped;
@end

@implementation HLPermenantThread
#pragma mark -public methods
- (instancetype)init
{
    if (self = [super init]) {
        self.isStopped = NO;
        __weak typeof(self) weakSelf = self;
        self.innerThread = [[HLThread alloc]initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
        //也可以不对外暴露run方法，让线程自动启动
//        [self.innerThread start];
    }
    return self;
}
-(void)run
{
    if (!self.innerThread) return;
    [self.innerThread start];
}
-(void)executeTask:(HLPermenantThreadTask)task
{
    if (!self.innerThread || !task) return;
    //注意withObject参数传的不是nil，而是task
    [self performSelector:@selector(hl_executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}
- (void)stop
{
    if (!self.innerThread) return;
    [self performSelector:@selector(hl_stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self stop];
}
#pragma mark -private methods
- (void)hl_stop
{
    self.isStopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}
- (void)hl_executeTask:(HLPermenantThreadTask)task
{
    task();
}
@end
