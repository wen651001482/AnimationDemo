//
//  ViewController.m
//  02-CoreAnimation
//
//  Created by wenjie on 2021/3/17.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *v;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginAnimation)];
	
	self.v = [[UIView alloc] init];
	self.v.backgroundColor = UIColor.redColor;
	self.v.frame = CGRectMake(10, 50, 100, 100);
	
	[self.v addGestureRecognizer:tap];
	[self.view addSubview: self.v];
	
}


- (void)beginAnimation {
	
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
}

@end
