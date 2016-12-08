//
//  ViewController.m
//  Demo3_CAAnimation
//
//  Created by tarena on 16/10/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//       [self position];
//    [self transform];
//    [self keyFrameAnimation];
    [self animationGroup];
}

-(void)position {
    //创建基础动画的对象
    CABasicAnimation *bAnim = [CABasicAnimation animation];
    //一个重要的设置： 设置动画要修改的内容
    //position   scale   rotation
    //使用kvc的方式为对象的属性赋值， 说明要修改的属性名是什么
    bAnim.keyPath = @"position";
    //指定动画结束时 具体的数值
    bAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    //指定动画开始时 具体的数值
    bAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 500)];

    //动画时长
    bAnim.duration = 2;
    //动画的重复次数
//    bAnim.repeatCount = MAXFLOAT;
    
    
    //动画结束时 不要把动画从视图上移除 要视图停留在动画结束位置 需要搭配 fillMode  属性一起使用
    bAnim.removedOnCompletion = NO;
    /*
    kCAFillModeRemoved 默认， 当动画开始前和动画结束后，动画对layer都没有影响， layer会一直保存动画前的状态
    kCAFillModeForwards 当动画结束后， layer会一直保持着动画最后的状态
    kCAFillModeBackwards 在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待运行动画
    kCAFillModeBoth 上面两个合在一起
     */
    bAnim.fillMode = kCAFillModeBoth;
    //设置动画开始 等待的事件
    bAnim.beginTime = CACurrentMediaTime() + 3;
    
    //运行动画  CA动画只能通过 layer运行
    [self.imageView.layer addAnimation:bAnim forKey:nil];
}

-(void)transform {
    CABasicAnimation *anim = [CABasicAnimation animation];
    
//    anim.keyPath = @"transform";
//    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    
   
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 2);
    
    anim.keyPath = @"transform.scale";
    anim.toValue = @1.2;
    
    
    anim.duration = 2;
    anim.repeatCount = MAXFLOAT;
    [self.imageView.layer addAnimation:anim forKey:nil];
}

//关键帧 动画
-(void)keyFrameAnimation {
    //创建 关键帧动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
//    anim.values = @[
//                    [NSValue valueWithCGPoint:CGPointMake(50, 50)],
//                    [NSValue valueWithCGPoint:CGPointMake(150, 150)],
//                    [NSValue valueWithCGPoint:CGPointMake(30, 200)],
//                    [NSValue valueWithCGPoint:CGPointMake(100, 300)],
//                    ];
    
    anim.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5) radius:150 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    
    
    anim.duration = 3;
    
    //动画结束 视图固定在结束位置
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    anim.repeatCount = 10;
    
    [self.imageView.layer addAnimation:anim forKey:nil];
    
    
}

//动画组
-(void)animationGroup {
    CABasicAnimation *positionYAnim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionYAnim.toValue = @(self.imageView.center.y - 130);
    
    CABasicAnimation *transformAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnim.toValue = @(M_PI);
    
    //创建动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //向组中 添加动画对象
    group.animations = @[positionYAnim,transformAnim];
    group.duration = 3;
    group.repeatCount = 10;
    
    //最后 让imageView的layer 运行 动画组
    [self.imageView.layer addAnimation:group forKey:nil];
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
