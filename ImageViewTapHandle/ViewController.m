//
//  ViewController.m
//  ImageViewTapHandle
//
//  Created by apple on 17/6/23.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGRect originFrame;
}

@property (nonatomic, strong) UIImageView *fullScreenImag;
@property (weak, nonatomic) IBOutlet UIImageView *beautifulImag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.beautifulImag.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.beautifulImag addGestureRecognizer:tapGesture1];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        originFrame = self.beautifulImag.frame;
        CGRect convertRect = [self.beautifulImag convertRect:self.beautifulImag.bounds toView:keyWindow];
        if (!self.fullScreenImag) {
            self.fullScreenImag = [[UIImageView alloc]initWithFrame:convertRect];
        }
        self.fullScreenImag.backgroundColor = [UIColor blackColor];
        self.fullScreenImag.image = self.beautifulImag.image;
        self.fullScreenImag.contentMode = UIViewContentModeScaleAspectFit;
        self.fullScreenImag.userInteractionEnabled = YES;
        [keyWindow addSubview:self.fullScreenImag];
        [UIView animateWithDuration:0.25f animations:^{
            self.fullScreenImag.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
        }];
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture2:)];
        [self.fullScreenImag addGestureRecognizer:tapGesture2];
    }
}

- (void)tapGesture2:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.25f animations:^{
            self.fullScreenImag.alpha = 0.0f;
            self.fullScreenImag.frame = originFrame;
        } completion:^(BOOL finished) {
            //在图片完全透明或者隐藏hidden，图片是不能从父视图中移除的
            //alpha = 0 和 hidden = yes区别
            //alpha = 0 控件完全透明，层级结构中能看到这个控件
            //hidden = yes 控件透明，层级结构中看不到这个控件
            self.fullScreenImag.alpha = 1.f;
            [self.fullScreenImag removeFromSuperview];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
