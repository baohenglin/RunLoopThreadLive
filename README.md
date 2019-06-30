## 1.线程保活的应用场景：
&emsp;&emsp;在iOS开发中，一些耗时操作如果在主线程执行的话会阻塞主线程，导致界面卡顿，那么我们就会创建一个子线程，并将这些耗时操作放入子线程进行处理。但是当子线程中的任务执行完毕后，子线程就会被销毁。如果在程序中，需要经常在子线程中执行，那么频繁地创建和销毁线程，会造成CPU资源的浪费。此时，我们就可以利用RunLoop来使该线程长时间存活而不被销毁（有消息待处理时，线程被唤醒，无消息处理时，线程休眠），也叫做“线程保活”或“线程常驻”。

## 2.使用方法：

* (1)导入头文件

```
#import "HLPermenantThread.h"
```

* (2)定义属性

```
@property (nonatomic, strong) HLPermenantThread *permenantThread;
```

* (3)创建子线程

```
self.permenantThread = [[HLPermenantThread alloc]init];
```

* (4)启动该子线程

```
[self.permenantThread run];
```

* (5)子线程执行任务

```
[self.permenantThread executeTask:^{
   NSLog(@"执行任务:%s %@",__func__,[NSThread currentThread]);
}];
```

* (6)停止该子线程

```
[self.permenantThread stop];
```


