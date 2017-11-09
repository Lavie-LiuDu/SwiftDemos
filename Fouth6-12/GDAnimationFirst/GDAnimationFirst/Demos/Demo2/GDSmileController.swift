//
//  GDSmileController.swift
//  GDAnimationFirst
//
//  Created by Lavie on 2017/11/7.
//  Copyright © 2017年 Lavie. All rights reserved.
//
//  理想状况下，当你设置了一个图层的透明度，你希望它包含的整个图层树像一个整体一样的透明效果。你可以通过设置Info.plist文件中的`UIViewGroupOpacity`为YES来达到这个效果，但是这个设置会影响到这个应用，整个app可能会受到不良影响。如果`UIViewGroupOpacity`并未设置，iOS 6和以前的版本会默认为NO（也许以后的版本会有一些改变）。

// 另一个方法就是，你可以设置CALayer的一个叫做`shouldRasterize`属性（见清单4.7）来实现组透明的效果，如果它被设置为YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了（如图4.21）。
//
// 为了启用`shouldRasterize`属性，我们设置了图层的`rasterizationScale`属性。默认情况下，所有图层拉伸都是1.0， 所以如果你使用了`shouldRasterize`属性，你就要确保你设置了`rasterizationScale`属性去匹配屏幕，以防止出现Retina屏幕像素化的问题。
//
// 当`shouldRasterize`和`UIViewGroupOpacity`一起的时候，性能问题就出现了（我们在第12章『速度』和第15章『图层性能』将做出介绍），但是性能碰撞都本地化了（译者注：这句话需要再翻译）。


import UIKit

class GDSmileController: UIViewController {

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var showLabel: UILabel!
    
    
    fileprivate lazy var layerView:UIView = {
        let layerV = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        layerV.backgroundColor = UIColor.gray
        return layerV
    }()
    
    fileprivate lazy var blueLayer:CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        layer.backgroundColor = UIColor.blue.cgColor
        return layer
    }()
    
    fileprivate var leftVcenter:CGPoint {
        return self.leftView.center
    }
    fileprivate var rightVcenter:CGPoint {
        
        return self.rightView.center
    }
    fileprivate var bottomFrame:CGRect {
        return self.bottomView.frame
    }
    fileprivate var bottomBounds:CGRect {
        return self.bottomView.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        //MARK:click To Start Animation
        self.chapter4()
        
        
//        self.useCAspringAnimation()
//        self.startRight()
//        self.startBottom()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        viewWillDisappear(animated)
//
//        self.leftView.layer.removeAllAnimations()
//        self.rightView.layer.removeAllAnimations()
//        self.bottomView.layer.removeAllAnimations()
//    }
    
    
    fileprivate func chapter4() {
        
        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .allowAnimatedContent, animations: {
            
            self.leftView.center = CGPoint(x: self.view.bounds.width - self.leftVcenter.x, y: self.leftVcenter.y + 30)
            self.rightView.center = CGPoint(x: self.view.bounds.width - self.rightVcenter.x
                , y: self.rightVcenter.y + 30)
            self.bottomView.frame.size = CGSize(width: self.bottomFrame.width, height: 180)
            
            self.view.layoutIfNeeded()
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .allowAnimatedContent, animations: {
                self.showLabel.isHidden = false
                
            }, completion: { (titleFinish) in
                
            })
            
        }
    }
    
    fileprivate func useCAspringAnimation() {
        
        let springA = CASpringAnimation(keyPath: "position")
        springA.fromValue = self.leftVcenter
        springA.toValue = CGPoint(x: self.view.bounds.width - self.leftVcenter.x, y: self.leftVcenter.y + 30)
        springA.isRemovedOnCompletion = false
        springA.duration = 0.8
        //MARK:阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
//        springA.damping = 0.6
        //MARK:刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
//        springA.stiffness = 0.5
        //MAKR:质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
//        springA.mass = 10
        self.leftView.layer.add(springA, forKey: "LeftA")
        
    }
    
    func startRight()  {
        
        let rightAnima = CASpringAnimation(keyPath: "position")
        rightAnima.fromValue = self.rightVcenter
        rightAnima.toValue = CGPoint(x: self.view.bounds.width - self.rightVcenter.x
            , y: self.rightVcenter.y + 30)
        rightAnima.duration = 0.8
        rightAnima.isRemovedOnCompletion = false

        self.rightView.layer.add(rightAnima, forKey: "rightA")

    }
    func startBottom() {
        
        let bottomAnima = CASpringAnimation(keyPath: "bounds")
        bottomAnima.fromValue = self.bottomBounds
        bottomAnima.toValue = CGRect(x: self.bottomBounds.origin.x, y: self.bottomBounds.origin.y, width: self.bottomBounds.width, height: 180)
        bottomAnima.duration = 0.8
        bottomAnima.isRemovedOnCompletion = false
        self.bottomView.layer.add(bottomAnima, forKey: "bottomA")

    }
}
