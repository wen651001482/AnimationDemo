//
//  ViewController.m
//  02-CoreAnimation
//
//  Created by wenjie on 2021/3/17.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (strong, nonatomic) UIView *v;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view setBackgroundColor: UIColor.whiteColor];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginAnimation)];
	
	self.v = [[UIView alloc] init];
	self.v.backgroundColor = UIColor.redColor;
	self.v.frame = CGRectMake(10, 50, 100, 100);
	
	[self.v addGestureRecognizer:tap];
	[self.view addSubview: self.v];
	
	[self useNSOperation];
}


- (void)beginAnimation {

//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		NSLog(@"go to play");
//	});

	__weak typeof(self)weakself = self;
	
	[UIView animateWithDuration:1.5 animations:^{
		CGAffineTransform transform = CGAffineTransformIdentity;
		//scale by 50%
		transform = CGAffineTransformScale(transform, 0.5, 0.5);
		//rotate by 30 degrees
		transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
		//translate by 200 points
		transform = CGAffineTransformTranslate(transform, 200, 0);
		//apply transform to layer
		weakself.v.layer.affineTransform = transform;
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0 animations:^{
			weakself.v.transform = CGAffineTransformMakeRotation(M_PI);
		}];
	}];
	
//	dispatch_async(dispatch_get_global_queue(0, 0), ^{
//		NSLog(@"异步全局队列%@", [NSThread currentThread]); // 开启子线程
//	});
//	dispatch_async(dispatch_get_main_queue(), ^{
//		NSLog(@"异步主队列%@", [NSThread currentThread]); // number = 1 回到主线程
//	});
	
}

- (void)useNSOperation {
// NSThread
//	[self performSelector:@selector(doSomething3:) withObject:@"djadal" afterDelay:1.0];
	
	// 如果number=1,则表示在主线程，否则是子线程
	NSLog(@"%@", [NSThread currentThread]);
//	//休眠多久
//	[NSThread sleepForTimeInterval:2];
//	//休眠到指定时间
//	[NSThread sleepUntilDate:[NSDate date]];
//	//退出线程
//	[NSThread exit];
//	//判断当前线程是否为主线程
//	[NSThread isMainThread];
//	//判断当前线程是否是多线程
//	[NSThread isMultiThreaded];
//	//主线程的对象
//	NSThread *mainThread = [NSThread mainThread];
	
/**NSOperation是个抽象类,并不具备封装操作的能力,必须使⽤它的子类
 
 使用NSOperation⼦类的方式有3种：

 （1）NSInvocationOperation

 （2）NSBlockOperation

 （3）自定义子类继承NSOperation,实现内部相应的⽅法*/
	// 创建NSInvocationOperation 程序在主线程同步执行，没有开启新线程。多线程的使用需要配合队列NSOperationQueue
	// NSInvocationOperation *invocationOperationMain = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
	// [invocationOperationMain start]; // 开始执行操作
	
	// 创建NSBlockOperation 程序在主线程同步执行，没有开启新线程。多线程的使用需要配合队列NSOperationQueue(但是NSBlockOperation有一个方法addExecutionBlock:，通过这个方法可以让NSBlockOperation实现多线程。)
	//NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
	//	NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
	// }];
	// [blockOperation start];
	
	/**
	 总结：NSBlockOperation是优先使用主线程，NSInvocationOperation在子线程中执行。俩者都是异步执行的。
	 */
	
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	queue.maxConcurrentOperationCount = 3; // 同时容许几个线程在执行 默认-1或大于1并行 开启多线程  =1表示不开线程，也就是串行。
	
	// 创建操作1，NSInvocationOperation
	NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAddOperation) object:nil];
	// 创建操作2，NSInvocationOperation
	NSInvocationOperation *operation2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doSomething3) object:nil];
	
	// 创建操作3，NSBlockOperation(两个任务)
	NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
		for (int i = 0; i < 3; i++) {
			NSLog(@"blockOperation-1===addOperation把任务添加到队列======%@", [NSThread currentThread]);
		}
	}];
	[operation3 addExecutionBlock:^{
		NSLog(@"blockOperation-2===addOperation把任务添加到队列======%@", [NSThread currentThread]);
	}];
	
	//设置操作依赖
	//先执行operation2，再执行operation1，最后执行operation3
	[operation3 addDependency:operation1];
	[operation1 addDependency:operation2];
	
	// 把操作添加到队列中  所有操作都是并发执行的 没有先后顺序
	[queue addOperation:operation1];
	[queue addOperation:operation2];
	[queue addOperation:operation3];
	
	// 队列暂停、恢复、取消、操作优先级、监听操作完成 (暂停和恢复的适用场合：在tableview界面，开线程下载远程的网络界面，对UI会有影响，使用户体验变差。那么这种情况，就可以设置在用户操作UI（如滚动屏幕）的时候，暂停队列（不是取消队列），停止滚动的时候，恢复队列。)
	
	/**更多使用方法参考： https://www.cnblogs.com/wendingding/p/3809150.html*/
}

- (void)invocationOperationAddOperation {
	for (int i=0; i<3; i++) {
		NSLog(@"NSInvocationOperation--test1--%@",[NSThread currentThread]);
	}
}

- (void)doSomething3 {
	for (int i=0; i<3; i++) {
		NSLog(@"NSInvocationOperation--test2--%@",[NSThread currentThread]);
	}
}



@end
