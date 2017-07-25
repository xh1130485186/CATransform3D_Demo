//
//  ViewController.m
//  CATransform3D_Demo
//
//  Created by 向洪 on 2017/7/20.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // CATransform3D是一个可以在3维空间内做变换的4x4的矩阵，用于图层的旋转，缩放，偏移，歪斜和应用的透视
    
    /*
     
     矩阵的意义如下：
     CGFloat        m11（x缩放）,      m12（y切变）,     m13（旋转）,        m14;
     
     CGFloat        m21（x切变）,      m22（y缩放）,     m23,              m24;
     
     CGFloat        m31（旋转）,       m32,            m33,              m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
     
     CGFloat        m41（x平移）,      m42（y平移）,     m43（z平移）,       m44(整体放大缩小，值越小，放大的倍数越大);
     
     */
    
    
    
    /*
     
     // 位移
     CA_EXTERN CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)
     CA_EXTERN CATransform3D CATransform3DTranslate (CATransform3D t, CGFloat tx, CGFloat ty, CGFloat tz)
     
     // 缩放
     CA_EXTERN CATransform3D CATransform3DMakeScale (CGFloat sx, CGFloat sy, CGFloat sz)
     CA_EXTERN CATransform3D CATransform3DScale (CATransform3D t, CGFloat sx, CGFloat sy, CGFloat sz)
     
     // 旋转, 沿x轴旋转 沿y轴旋转 沿z轴旋转(相当于平面旋转) 取值都为 -1 ~ 1 之间
     CA_EXTERN CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
     CA_EXTERN CATransform3D CATransform3DRotate (CATransform3D t, CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
    
     // 链接2个CATransform3D，相乘
     CA_EXTERN CATransform3D CATransform3DConcat (CATransform3D a, CATransform3D b)
     
     // 反转CATransform3D，翻转效果
     CA_EXTERN CATransform3D CATransform3DInvert (CATransform3D t)
     
     // CGAffineTransform 转 CATransform3D，他们的效果相同
     CA_EXTERN CATransform3D CATransform3DMakeAffineTransform (CGAffineTransform m)
     
     // CATransform3D能否用CGAffineTransform来表示，转换的时候应该判断一下
     CA_EXTERN bool CATransform3DIsAffine (CATransform3D t)
     
     // CATransform3D 转 CGAffineTransform
     CA_EXTERN CGAffineTransform CATransform3DGetAffineTransform (CATransform3D t)
     
     // 判断是否是默认的CATransform3D
     CA_EXTERN bool CATransform3DIsIdentity (CATransform3D t)
     
     // 判断2个CATransform3D是否完全一致
     CA_EXTERN bool CATransform3DEqualToTransform (CATransform3D a,
     CATransform3D b)
     
     
     */
    
    
//    self.view.backgroundColor = [UIColor orangeColor];
    
//    CALayer *layer_reference = [CALayer layer];
//    layer_reference.bounds = CGRectMake(0, 0, 300, 330);
//    layer_reference.position = self.view.center;
//    layer_reference.backgroundColor = [UIColor orangeColor].CGColor;
//    layer_reference.opacity = 0.6;
//    [self.view.layer addSublayer:layer_reference];
//    
//    
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 300, 330);
//    layer.position = self.view.center;
//    layer.contentsGravity = kCAGravityResizeAspectFill;
//    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"2.png"].CGImage);
//    
//    [self.view.layer addSublayer:layer];
    
    
//    [self transform3D_m34:layer];
    
    
    // 5.灭点
    // 当在透视角度绘图的时候，远离相机视角的物体将会变小变远，当远离到一个极限距离，它们可能就缩成了一个点，于是所有的物体最后都汇聚消失在同一个点。在做3d视图变换的时候，应该重这个点开始考虑。
    
    [self trannsform3D_sublayerTransform];
    
}

- (void)NSLogWithTransform3D:(CATransform3D)transform3D {

    NSLog(@"m11 = %lf, m12 = %lf, m13 = %lf, m14 = %lf", transform3D.m11, transform3D.m12, transform3D.m13, transform3D.m14);
    NSLog(@"m21 = %lf, m22 = %lf, m23 = %lf, m24 = %lf", transform3D.m21, transform3D.m22, transform3D.m23, transform3D.m24);
    NSLog(@"m31 = %lf, m32 = %lf, m33 = %lf, m34 = %lf", transform3D.m31, transform3D.m32, transform3D.m33, transform3D.m34);
    NSLog(@"m41 = %lf, m42 = %lf, m43 = %lf, m44 = %lf", transform3D.m41, transform3D.m42, transform3D.m43, transform3D.m44);
}

#pragma mark - 位移
- (void)transform3D_translate:(CALayer *)layer {

    // 位移 tz 可以设置图层的先后顺序
    // CA_EXTERN CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)
    // CA_EXTERN CATransform3D CATransform3DTranslate (CATransform3D t, CGFloat tx, CGFloat ty, CGFloat tz)
    // 直接设置transform3D的 m41(tx) m42(ty) m43(tz) 也可以到达一样的效果
    CATransform3D transform3D = CATransform3DMakeTranslation(50, 50, -1);
    layer.transform = transform3D;
    
}
#pragma mark - 缩放
- (void)transform3D_scale:(CALayer *)layer {
    
    // 缩放
    // CA_EXTERN CATransform3D CATransform3DMakeScale (CGFloat sx, CGFloat sy, CGFloat sz)
    // CA_EXTERN CATransform3D CATransform3DScale (CATransform3D t, CGFloat sx, CGFloat sy, CGFloat sz)
    // 也可以直接设置 m11（x缩放） m22（y缩放） m33 对应 sz m44(整体放大缩小，值越小，放大的倍数越大)
    // 这里设置sz并没有效果，没有找到原因，可能使用方法不对。
    CATransform3D transform3D = CATransform3DMakeScale(0.5, 0.5, 2);
    // m44 越小放大的倍数越大，越大放大的倍数越小。
    transform3D.m44 = 0.4;
    layer.transform = transform3D;
    
}

#pragma mark - 旋转

- (void)transform3D_rotate:(CALayer *)layer {

    // 旋转, 沿x轴旋转 沿y轴旋转 沿z轴旋转(相当于平面旋转) 取值都为 -1 ~ 1 之间
    // CA_EXTERN CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
    // CA_EXTERN CATransform3D CATransform3DRotate (CATransform3D t, CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
    // x轴旋转45°
    // angle x y z 共同决定了 m11 ~ m33 直接的参数值。由于我没有找到一个算法和规律,这里不进行说明.
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DRotate(transform3D, M_PI_4, 1, 0, 0);
    layer.transform = transform3D;
    [self NSLogWithTransform3D:transform3D];
}

#pragma mark - x缩放

- (void)transform3D_m11:(CALayer *)layer {

    CATransform3D transform3D = CATransform3DIdentity;
    // 设置倍数
    transform3D.m11 = 2;
    layer.transform = transform3D;
}

#pragma mark - y缩放

- (void)transform3D_m22:(CALayer *)layer {
    
    CATransform3D transform3D = CATransform3DIdentity;
    // 设置倍数
    transform3D.m22 = 2;
    layer.transform = transform3D;
}

#pragma mark - x,y缩放

- (void)transform3D_m44:(CALayer *)layer {
    
    CATransform3D transform3D = CATransform3DIdentity;
    // 设置倍数 值越小放大的倍数越高，默认值为1
    transform3D.m44 = 0.5;
    layer.transform = transform3D;
}

#pragma mark - y切变

- (void)transform3D_m12:(CALayer *)layer {
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m12 = 1;
    layer.transform = transform3D;
}

#pragma mark - x切变

- (void)transform3D_m21:(CALayer *)layer {
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m21 = 1;
    layer.transform = transform3D;
}

#pragma mark - 透视效果 m14
// m14 m24 m34 都能才生layer内容的变形（透视效果），m34只能在图片做了旋转后才有效果。
// m14 m24 m34 在旋转的时候选设置和后设置，都会产生不同的效果。m14 m24 m34的值会影响旋转函数的设置值
// m14 m24 m34 的默认值是0，我们可以通过设置m34为-1.0 / d来应用透视效果，这里d代表了想象中视角和屏幕之间的距离，以像素为单位，d通常为500-1000，d正负都可以。
- (void)transform3D_m14:(CALayer *)layer {
    
    // 以layer的中心开始，左右分别成渐变的放大缩小，
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m14 = -0.005;
    layer.transform = transform3D;
}

#pragma mark - 透视效果 m24

- (void)transform3D_m24:(CALayer *)layer {
    
    // 以layer的中心开始，上下分别成渐变的放大缩小，
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m24 = -0.005;
    layer.transform = transform3D;
}

#pragma mark - 透视效果 m34

- (void)transform3D_m34:(CALayer *)layer {
    
    // m34只能在图片做了旋转后才有效果。
    CATransform3D transform3D = CATransform3DIdentity;
    // 必须先设置 m34，然后再做旋转，不然不会产生效果
    transform3D.m34 = -0.005;
    transform3D = CATransform3DRotate(transform3D, M_PI_4, 0, 1, 0);
    layer.transform = transform3D;
}


#pragma mark - x,y 平移

- (void)transform3D_m13:(CALayer *)layer {
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m41 = 50;
    transform3D.m42 = 50;
    layer.transform = transform3D;
}


#pragma mark - sublayerTransform

// 调用前，先移除之前添加的视图
- (void)trannsform3D_sublayerTransform {

    // 灭点:当在透视角度绘图的时候，远离相机视角的物体将会变小变远，当远离到一个极限距离，它们可能就缩成了一个点，于是所有的物体最后都汇聚消失在同一个点。在做3d视图变换的时候，应该重这个点开始考虑。
    // 当改变一个图层的position，你也改变了它的灭点，当你视图通过调整m34来让它更加有3D效果，应该首先把它放置于屏幕中央，然后通过平移来把它移动到指定位置（而不是直接改变它的position），这样所有的3D图层都共享一个灭点。
    /*
     举例：CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，但和对一个图层的变换不同，它影响到所有的子图层。通过在一个地方设置透视变换会很方便，同时它会带来另一个显著的优势：灭点被设置在容器图层的中点，从而不需要再对子图层分别设置了。这意味着你可以随意使用position和frame来放置子图层，而不需要把它们放置在屏幕中点，然后为了保证统一的灭点用变换来做平移。
     */
    CALayer *content_layer = [CALayer layer];
    content_layer.bounds  = CGRectMake(0, 0, 300, 300);
    content_layer.position = self.view.center;
    content_layer.backgroundColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:content_layer];
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(30, 20, 120, 260);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    layer1.opacity = 0.6;
    [content_layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(150, 20, 120, 260);
    layer2.backgroundColor = [UIColor orangeColor].CGColor;
    layer2.opacity = 0.6;
    [content_layer addSublayer:layer2];
    
    CATransform3D content_transform3D = CATransform3DIdentity;
    content_transform3D.m34 = -0.005;
    content_layer.sublayerTransform = content_transform3D;
    
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    layer1.transform = transform1;
    
    
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    layer2.transform = transform2;
    
    // 这里是单独对sublayer就行透视的代码
//    CATransform3D transform1 = CATransform3DIdentity;
//    transform1.m34 = -0.005;
//    transform1 = CATransform3DRotate(transform1, M_PI_4, 0, 1, 0);
//    layer1.transform = transform1;
//    
//    
//    CATransform3D transform2 = CATransform3DIdentity;
//    transform2.m34 = -0.005;
//    transform2 = CATransform3DRotate(transform2, -M_PI_4, 0, 1, 0);
//    layer2.transform = transform2;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
