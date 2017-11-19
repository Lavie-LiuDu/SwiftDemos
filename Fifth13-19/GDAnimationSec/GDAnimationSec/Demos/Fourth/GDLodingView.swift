//
//  GDLodingView.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

let lineWidth:CGFloat = 16.0
let MultipleValue:CGFloat = 4


class GDLodingView: UIView {
   
    fileprivate var redLayer:CAShapeLayer?
    fileprivate var yellowLayer:CAShapeLayer?
    fileprivate var blueLayer:CAShapeLayer?
    fileprivate var greenLayer:CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        let redPath = creatPath(startPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width / MultipleValue, y: self.bounds.width))
        let yellowPath = creatPath(startPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0), toPoint: CGPoint(x: self.bounds.width, y: self.bounds.width - self.bounds.width / MultipleValue))
        let bluePath = creatPath(startPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: 0))
        let greenPath = creatPath(startPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width), toPoint: CGPoint(x: 0, y: self.bounds.width / MultipleValue))
        
        self.redLayer = creatLayer(layerColor: UIColor.red, path: redPath)
        self.yellowLayer = creatLayer(layerColor: UIColor.yellow, path: yellowPath)
        self.blueLayer = creatLayer(layerColor: UIColor.blue, path: bluePath)
        self.greenLayer = creatLayer(layerColor: UIColor.green, path: greenPath)
        
        self.layer.addSublayer(redLayer!)
        self.layer.addSublayer(yellowLayer!)
        self.layer.addSublayer(blueLayer!)
        self.layer.addSublayer(greenLayer!)
    }
    
    private func creatPath(startPoint:CGPoint, toPoint:CGPoint) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: toPoint)
        return bezierPath
    }
    private func creatLayer(layerColor:UIColor, path:UIBezierPath) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = layerColor.cgColor
        shapeLayer.strokeColor = layerColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.opacity = 0.7
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineJoinRound
        shapeLayer.path = path.cgPath
        return shapeLayer
    }

    //MARK:旋转
    fileprivate func creatRotationAnimation(duration:CFTimeInterval) -> CABasicAnimation {
        
        let rotaionAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotaionAnimation.toValue = Double.pi * 2
        rotaionAnimation.duration = duration
//        rotaionAnimation.repeatCount = MAXFLOAT
        rotaionAnimation.isRemovedOnCompletion = false
        return rotaionAnimation
    }
    //MARK:缩放
    fileprivate func creatScaleAnimation(duration:CFTimeInterval) -> CABasicAnimation {
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 0.3
        scaleAnimation.fromValue = 1.0
        //MARK:变圆之后再缩放
        scaleAnimation.duration = duration
//        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.autoreverses = true
        scaleAnimation.isRemovedOnCompletion = false
        return scaleAnimation
    }
    
    //
    fileprivate func toCycle() {
        
        let redPath = creatPath(startPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width / MultipleValue, y: self.bounds.width))

        let yellowPath = creatPath(startPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0), toPoint: CGPoint(x: self.bounds.width, y: self.bounds.width - self.bounds.width / MultipleValue))
     
        let bluePath = creatPath(startPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: 0))
        let greenPath = creatPath(startPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width), toPoint: CGPoint(x: 0, y: self.bounds.width / MultipleValue))

        self.toChangeShapeAnimation(layer: self.redLayer!, startPath: redPath, toPath: creatPath(startPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue)))
        
        self.toChangeShapeAnimation(layer: self.yellowLayer!, startPath: yellowPath, toPath: creatPath(startPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0), toPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0)))
        self.toChangeShapeAnimation(layer: self.blueLayer!, startPath: bluePath, toPath: creatPath(startPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue), toPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue)))
        self.toChangeShapeAnimation(layer: self.greenLayer!, startPath: greenPath, toPath: creatPath(startPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width), toPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width)))
    }
    
    fileprivate func toLong() {
        
        let redPath = creatPath(startPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width / MultipleValue, y: self.bounds.width))
        let yellowPath = creatPath(startPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0), toPoint: CGPoint(x: self.bounds.width, y: self.bounds.width - self.bounds.width / MultipleValue))
        let bluePath = creatPath(startPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: 0))
        let greenPath = creatPath(startPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width), toPoint: CGPoint(x: 0, y: self.bounds.width / MultipleValue))

        self.toChangeShapeAnimation(layer: self.redLayer!, startPath: creatPath(startPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue), toPoint: CGPoint(x: self.bounds.width, y: self.bounds.width / MultipleValue)), toPath: redPath)
        self.toChangeShapeAnimation(layer: self.yellowLayer!, startPath: creatPath(startPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0), toPoint: CGPoint(x: self.bounds.width / MultipleValue, y: 0)), toPath: yellowPath)
        self.toChangeShapeAnimation(layer: self.blueLayer!, startPath: creatPath(startPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue), toPoint: CGPoint(x: 0, y: self.bounds.width - self.bounds.width / MultipleValue)), toPath: bluePath)
        self.toChangeShapeAnimation(layer: self.greenLayer!, startPath: creatPath(startPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width), toPoint: CGPoint(x: self.bounds.width - self.bounds.width / MultipleValue, y: self.bounds.width)), toPath: greenPath)
    }
    
    fileprivate func toChangeShapeAnimation(layer:CAShapeLayer, startPath:UIBezierPath, toPath:UIBezierPath, duration:CFTimeInterval = 0.5) {
        
        layer.path = toPath.cgPath
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = duration
        animation.fromValue = startPath.cgPath
        animation.toValue = toPath.cgPath
        layer.add(animation, forKey: nil)
    }
    
}

extension GDLodingView {
    
    func startAnimation() {
        
        let rotationDuration = 3.0
        let scaleDuration = 1.0 // 缩放减半
        
        self.layer.add(creatRotationAnimation(duration: rotationDuration), forKey: "rotation")
        self.toCycle()
        let _ = delay(1.0) {[weak self] in
            self?.layer.add((self?.creatScaleAnimation(duration:scaleDuration))!, forKey: "scale")
        }
        let _ = delay(scaleDuration * 2) {
            self.toLong()
        }
        
    }
    func stopAnimation() {
        
        self.redLayer?.removeAllAnimations()
        self.yellowLayer?.removeAllAnimations()
        self.blueLayer?.removeAllAnimations()
        self.greenLayer?.removeAllAnimations()
        self.layer.removeAllAnimations()
    }
}
