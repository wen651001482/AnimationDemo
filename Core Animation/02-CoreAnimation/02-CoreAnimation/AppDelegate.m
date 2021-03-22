//
//  AppDelegate.m
//  02-CoreAnimation
//
//  Created by wenjie on 2021/3/17.
//

#import "AppDelegate.h"
#import "KNMovieViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	//刚开始肯定是NO. 因为没有保存过YES 放到userDefaults 里面.
	BOOL isFirstUp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoad"];
	
	//首先说明一下。 我这里是随便写的一个判断首次进入。下面说明正确写法
	//1.首先要从服务器获取到版本号
	//2.然后获取到Xcode设置版本号，把本地版本号上传到服务器。以方便下次比较
	//3.开始比较。版本号不同就设置启动页面。 这个看具体需求。因为有些app升级之后是不会出现启动页面的。
	//那是因为别人不需要每次升级都出现引导页。
	
	if (!isFirstUp) //如果本地缓存的数值是YES 就代表保存过
	{
		//存到本地UserDefaults 里面
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLoad"];
		
		//然后再跳转到播放视频的画面
		KNMovieViewController *KNVC = [[KNMovieViewController alloc]init];
		// 1、获取媒体资源地址
		NSString *path =  [[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:nil];
		KNVC.movieURL = [NSURL fileURLWithPath:path];
		self.window.rootViewController = KNVC;
	}else{
		//不是首次启动
		ViewController *rootTabCtrl = [[ViewController alloc]init];
		self.window.rootViewController = rootTabCtrl;
	}
	
	return YES;
}


@end
