//
//  GDHeartController.swift
//  GDAnimationFirst
//
//  Created by Lavie on 2017/11/7.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDHeartController: UIViewController {

    @IBOutlet weak var pictureV: UIImageView!
    
    fileprivate lazy var heartView:GDHeart = {
        let heartV = GDHeart(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        heartV.backgroundColor = UIColor.white
        return heartV
    }()
    
    fileprivate var heartPath:UIBezierPath = UIBezierPath()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startHeartAnimation()
        self.startFadeAnimation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.heartView.stop()
    }
    
    fileprivate func startFadeAnimation() {
        
        UIView.animate(withDuration: 2.0, animations: {
            self.pictureV.alpha = 0
        }) { (finish) in
            self.pictureV.removeFromSuperview()
        }
    }
    
    fileprivate func startHeartAnimation() {
        
        let rect = self.heartView.frame
        let padding:CGFloat = 4.0
        let curveRadius:CGFloat = (rect.width - 2 * padding) / padding
        let tipLocation = CGPoint(x: rect.size.width / 2, y: rect.size.height - padding)
       
        heartPath.move(to: tipLocation)
        let topLeftCurveStart = CGPoint(x: padding, y: rect.size.height / 2.4)
        heartPath.addQuadCurve(to: topLeftCurveStart, controlPoint: CGPoint(x: topLeftCurveStart.x, y: topLeftCurveStart.y + curveRadius))
        heartPath.addArc(withCenter: CGPoint(x: topLeftCurveStart.x + curveRadius, y: topLeftCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        let topRightCurveStart = CGPoint(x: topLeftCurveStart.x + 2 * curveRadius, y: topLeftCurveStart.y)
        heartPath.addArc(withCenter: CGPoint(x: topRightCurveStart.x + curveRadius, y: topRightCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        let topRightCurveEnd = CGPoint(x: topLeftCurveStart.x + 4 * curveRadius, y: topRightCurveStart.y)
        heartPath.addQuadCurve(to: tipLocation, controlPoint: CGPoint(x: topRightCurveEnd.x, y: topRightCurveEnd.y + curveRadius))
        
        let heartLayer = CAShapeLayer()
        heartLayer.path = heartPath.cgPath
        heartLayer.fillColor = UIColor.white.cgColor
        heartLayer.strokeColor = UIColor.red.cgColor
        heartLayer.lineWidth = 3.0
        heartLayer.frame = rect
        
        self.view.layer.addSublayer(heartLayer)
        self.drawLineAnimation(drawShape: heartLayer)
    }
    
    fileprivate func drawLineAnimation(drawShape:CALayer) {
        
        let drawanimation = CABasicAnimation(keyPath: "strokeEnd")
        drawanimation.duration = 1.0
        drawanimation.delegate = self
        drawanimation.fromValue = 0
        drawanimation.toValue = 1
        drawanimation.isRemovedOnCompletion = true
        
        drawShape.add(drawanimation, forKey: "Draw")
        
    }
    
}

extension GDHeartController:CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        self.view.layer.removeAllAnimations()
        
        self.view.addSubview(self.heartView)
        self.heartView.startHeartBeat()
    }
}


class GDHeart: UIView {
    
    fileprivate var bezierP = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        
        let padding:CGFloat = 4.0
        let curveRadius:CGFloat = (rect.width - 2 * padding) / padding
        
        //MARK:起点
        let tipLocation = CGPoint(x: rect.size.width / 2, y: rect.size.height - padding)
        bezierP.move(to: tipLocation)
        
        let topLeftCurveStart = CGPoint(x: padding, y: rect.size.height / 2.4)
        bezierP.addQuadCurve(to: topLeftCurveStart, controlPoint: CGPoint(x: topLeftCurveStart.x, y: topLeftCurveStart.y + curveRadius))
        //MARK:画圆
        bezierP.addArc(withCenter: CGPoint(x: topLeftCurveStart.x + curveRadius, y: topLeftCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        let topRightCurveStart = CGPoint(x: topLeftCurveStart.x + 2 * curveRadius, y: topLeftCurveStart.y)
        bezierP.addArc(withCenter: CGPoint(x: topRightCurveStart.x + curveRadius, y: topRightCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        let topRightCurveEnd = CGPoint(x: topLeftCurveStart.x + 4 * curveRadius, y: topRightCurveStart.y)
        bezierP.addQuadCurve(to: tipLocation, controlPoint: CGPoint(x: topRightCurveEnd.x, y: topRightCurveEnd.y + curveRadius))
        
        UIColor.red.setFill()
        bezierP.fill()
        
        bezierP.lineWidth = 1.0
        bezierP.lineCapStyle = .round
        bezierP.lineJoinStyle = .round
        
        UIColor.red.setStroke()
        bezierP.stroke()
    }
    
    func startHeartBeat() {
        
        let scaleanimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleanimation.values = [1.0, 1.5, 1.0]
        scaleanimation.duration = 0.5
        scaleanimation.repeatCount = MAXFLOAT
        scaleanimation.isRemovedOnCompletion = false
        scaleanimation.fillMode = kCAFillModeForwards

        self.layer.add(scaleanimation, forKey: "HeartBeat")
    }

    func stop() {
        
        self.layer.removeAllAnimations()
    }
}

