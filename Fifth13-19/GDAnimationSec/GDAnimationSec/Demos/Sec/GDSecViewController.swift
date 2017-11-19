//
//  GDSecViewController.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//
/*
 CAGradientLayer`是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个`CAGradientLayer`并将内容绘制到一个普通图层的寄宿图也是有可能的，但是`CAGradientLayer`的真正好处在于绘制使用了硬件加速
 
 CAReplicatorLayer`的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。
 */

import UIKit

class GDSecViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        simplegradient()
        simplereplicatorLayer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.containerView.layer.removeAllAnimations()
    }
    
    fileprivate func simplegradient() {
        
        //create gradient layer and add it to our container view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(gradientLayer)
        //set gradient colors
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor]
        //set locations
        gradientLayer.locations = [0, 0.3, 0.7]
        //set gradient start and end points
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    fileprivate func simplereplicatorLayer() {
        //create a replicator layer and add it to our view
        let replicator = CAReplicatorLayer()
        replicator.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(replicator)
        //configure the replicator
        replicator.instanceCount = 8
        //设置子层相对于前一个层的延迟时间
        replicator.instanceDelay = 0.2
        replicator.instanceColor = UIColor.green.cgColor
        
        //apply a transform for each instance
//        var transform:CATransform3D = CATransform3DIdentity
//        transform = CATransform3DTranslate(transform, 0, 200, 0)
//        transform = CATransform3DRotate(transform, CGFloat(.pi / 5.0), 0, 0, 1)
//        transform = CATransform3DTranslate(transform, 0, -200, 0)

        replicator.instanceTransform = CATransform3DMakeTranslation(40, 0, 0)
       
        //apply a color shift for each instance  颜色的渐变，相对于前一个层的渐变（取值-1~+1）.RGB有三种颜色，所以这里也是绿红蓝三种。
        replicator.instanceBlueOffset = -2;
        replicator.instanceGreenOffset = -0.2;
        replicator.instanceRedOffset = -0.2
        
        //create a sublayer and place it inside the replicator
        let layer = CALayer()
        layer.frame = CGRect(x: 10, y: 40, width: 10, height: 80)
        layer.backgroundColor = UIColor.white.cgColor
        layer.add(scaleAnimation(), forKey: "Scale")
        replicator.addSublayer(layer)
        
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.toValue = 0.1
        animation.duration = 0.4
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        return animation
    }
}
