//
//  ViewController.m
//  Test21
//
//  Created by 小雨科技 on 2017/8/9.
//  Copyright © 2017年 jiajianhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self shapelayer];
//    [self gradientlayer];
//    [self replicatorLayer];
    [self countdown];
 
}
#pragma mark -- CAShapeLayer
-(void)shapelayer{
    //边框羽化效果
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"launch_5"]];
    [self.view addSubview:image];
    image.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    CGMutablePathRef ms = CGPathCreateMutable();
    //CGPathAddEllipseInRect(ms, nil, CGRectInset(CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width), 50,50));画圆
    CGPathAddRect(ms, nil, CGRectInset(CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width), 50,50));//画方
    shape.path = ms;
    //shape.fillColor = [UIColor greenColor].CGColor;
    shape.shadowOpacity = 1;
    shape.shadowRadius = 50;
    image.layer.mask = shape;
}

#pragma mark -- CAGradientLayer
NSNumber *DegreesToNumber(CGFloat degrees) {
    return [NSNumber numberWithFloat: DegreesToRadians(degrees)];
}
CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;}

-(void)gradientlayer{
//    [[[self view] layer]setBackgroundColor:
//     [[UIColor blackColor]CGColor]];
//倒影效果
    UIImage *balloon = [UIImage imageNamed:@"launch_5"];//换图片即可
    // Create the top layer; thisis the main image
    CALayer *topLayer = [[CALayer alloc] init];
    [topLayer setBounds:CGRectMake(0.0f, 0.0f, 320.0, 240.0)];
    [topLayer setPosition:CGPointMake(160.0f, 120.0f)];
    [topLayer setContents:(id)[balloon CGImage]];
    // Add the layer to the view
    [[[self view] layer]addSublayer:topLayer];
    // Create the reflectionlayer; this image is displayed beneath // the top layer
    CALayer *reflectionLayer =[[CALayer alloc] init];
    [reflectionLayer setBounds:CGRectMake(0.0f, 0.0f,320.0, 240.0)];
    [reflectionLayer setPosition:CGPointMake(158.0f, 362.0f)];
    // Use a copy of the imagecontents from the top layer // for the reflection layer
    [reflectionLayer setContents:[topLayer contents]];
    // Rotate the image 180degrees over the x axis to flip the image
    [reflectionLayer setValue:DegreesToNumber(180.0f) forKeyPath:@"transform.rotation.x"];
    // Create a gradient layer touse as a mask for the
    // reflection layer
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    [gradientLayer setBounds:[reflectionLayer bounds]];
    [gradientLayer setPosition:
     CGPointMake([reflectionLayer bounds].size.width/2, [reflectionLayer bounds].size.height/2)];
    [gradientLayer setColors:[NSArray arrayWithObjects: (id)[[UIColor clearColor] CGColor],
                              (id)[[UIColor blackColor]CGColor], nil]];
    // Override the default startand end points to give the gradient // the right look
    [gradientLayer setStartPoint:CGPointMake(0.5,0.35)];
    [gradientLayer setEndPoint:CGPointMake(0.5,1.0)];
    // Set the reflection layer’smask to the gradient layer
    [reflectionLayer setMask:gradientLayer];
    // Add the reflection layerto the view
    [[[self view] layer]addSublayer:reflectionLayer];
    
 
}

#pragma mark --  CAReplicatorLayer
-(void)replicatorLayer{
    CGMutablePathRef ms = CGPathCreateMutable();
    CGPathAddEllipseInRect(ms, nil, CGRectInset(CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width), 50,50));
    
    // 具体的layer
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    tView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width +50, 250);
    tView.layer.cornerRadius = 5;
//    tView.hidden=YES;
    tView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
//    tView.backgroundColor=[UIColor clearColor];
    // 动作效果
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = ms;
    loveAnimation.duration = 8;
    loveAnimation.repeatCount = MAXFLOAT;
    loveAnimation.autoreverses=NO;
//    loveAnimation.removedOnCompletion = YES;
//    loveAnimation.fillMode = kCAFillModeForwards;
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    CAReplicatorLayer *loveLayer = [CAReplicatorLayer layer];
    loveLayer.instanceCount = 40;                // 40个layer
    loveLayer.instanceDelay = 0.2;               // 每隔0.2出现一个layer
    loveLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0].CGColor;
    loveLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
    loveLayer.instanceRedOffset = -0.02;         // 颜色值递减。
    loveLayer.instanceBlueOffset = -0.01;        // 颜色值递减。
    loveLayer.instanceAlphaOffset = 0.1;         // 颜色值递增。

    [loveLayer addSublayer:tView.layer];
    [self.view.layer addSublayer:loveLayer];
 
}

#pragma mark -倒计时
-(void)countdown{
    
    CATextLayer *A = [CATextLayer layer];
    A.string = @"Fly";
    A.fontSize = 24;
    A.foregroundColor = [UIColor blackColor].CGColor;
    A.bounds = CGRectMake(0, 0, 48, 48);
    A.position = self.view.center;
    [self.view.layer addSublayer:A];
    
    // Move animation.
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds))], [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMinY(self.view.bounds))], [NSValue valueWithCGPoint:CGPointMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds))], nil];
    move.calculationMode = kCAAnimationLinear;
    move.duration = 10;
    move.speed = 2;
    
    // Opacity animation.
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = [NSNumber numberWithFloat:0.9];
    opacity.toValue = [NSNumber numberWithFloat:0];
    opacity.duration = 2.5;
    opacity.beginTime = 2.5; // Fade from the half way.
    
    // Animatin group.
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:move, opacity, nil];
    group.duration = 8;
    group.repeatCount = HUGE_VALF;
    
    // Time warp.
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval currentTimeInSuperLayer = [self.view.layer convertTime:currentTime fromLayer:nil];
    A.beginTime = currentTimeInSuperLayer + 5; // Delay the appearance of A.
    CFTimeInterval currentTimeInLayer = [A convertTime:currentTimeInSuperLayer fromLayer:self.view.layer];
    CFTimeInterval addTime = currentTimeInLayer;
    group.beginTime = addTime + 3; // Delay the animatin group.
    
    [A addAnimation:group forKey:nil];
    
    // Timer. For nice visual effect. Optional.
    CATextLayer *timer = [CATextLayer layer];
    timer.fontSize = 48;
    timer.foregroundColor = [UIColor redColor].CGColor;
    timer.bounds = CGRectMake(0, 0, 48, 48);
    timer.position = self.view.center;
    [self.view.layer addSublayer:timer];
    CAKeyframeAnimation *count = [CAKeyframeAnimation animationWithKeyPath:@"string"];
    count.values = [NSArray arrayWithObjects:@"5", @"4", @"3", @"2", @"1", nil];
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    fade.toValue = [NSNumber numberWithFloat:0.2];
    group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:count, fade, nil];
    group.duration = 5;
    [timer addAnimation:group forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
