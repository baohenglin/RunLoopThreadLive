//
//  HLPermenantThread.h
//  RunLoop线程保活封装
//
//  Created by BaoHenglin on 2019/6/29.
//  Copyright © 2019 BaoHenglin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^HLPermenantThreadTask)(void);
NS_ASSUME_NONNULL_BEGIN

@interface HLPermenantThread : NSObject
//添加注释快捷键：option+command+/
/**
 开启一个线程
 */
- (void)run;
/**
 结束一个线程
 */
- (void)stop;
/**
 在x子线程执行一个任务
 */
//- (void)executeTaskWithTarget:(id)target action:(SEL)action object:(id)object;
- (void)executeTask:(HLPermenantThreadTask)task;
@end

NS_ASSUME_NONNULL_END
