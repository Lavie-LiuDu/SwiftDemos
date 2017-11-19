//
//  GDFirstViewController.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFirstViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    
    fileprivate var percent:Float = 0.0
    fileprivate var currentPer:Float = 0
    fileprivate lazy var link:CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(refreshLayerAnimation))
        link.isPaused = true
        link.preferredFramesPerSecond = 30
        return link
    }()
    fileprivate lazy var path:UIBezierPath = {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 100, startAngle: 0, endAngle: CGFloat(2.0 * .pi), clockwise: true)
        return path
    }()
    
    fileprivate lazy var progressLayer:CAShapeLayer = {
        let progresslayr = CAShapeLayer()
        return progresslayr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.link.add(to: RunLoop.current, forMode: .commonModes)
        self.creatcircular()
//        self.creatTextlayer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.link.invalidate()
    }

    fileprivate func creatcircular() {

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = self.path.cgPath
        shapeLayer.lineWidth = 8.0
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineJoin = kCALineJoinRound
        
        self.containerView.layer.addSublayer(shapeLayer)
        
        progressLayer.path = self.path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0.0
        progressLayer.lineWidth = 8.0
        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineJoin = kCALineJoinRound
        self.containerView.layer.addSublayer(self.progressLayer)

    }
    
    fileprivate func creatTextlayer() {
        
        //MARK:相比于lable渲染更快，但是不能实时更新
        let textlayer = CATextLayer()
        textlayer.frame = self.labelView.bounds
        textlayer.foregroundColor = UIColor.blue.cgColor
        textlayer.contentsScale = UIScreen.main.scale
        self.labelView.layer.addSublayer(textlayer)
        
        textlayer.alignmentMode = kCAAlignmentCenter
        textlayer.isWrapped = true
        textlayer.fontSize = 15.0
        let text = NSMutableAttributedString(string: "\(percent) \n已使用流量")
        text.addAttributes([kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.blue.cgColor], range: NSRange(location: 0, length: "\(percent)".characters.count))
        text.addAttributes([kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.black.cgColor], range: NSRange(location: "\(percent)".characters.count, length: "已使用流量".characters.count))
        textlayer.string = text
    }
    
    @objc func refreshLayerAnimation() {
        
        if self.currentPer > self.percent && self.currentPer < self.percent {
            self.stopAnimation()
            self.progressLayer.strokeEnd = CGFloat(self.percent / 100)
            self.percentLabel.text = "\(self.percent)%"
            return
        }
        if self.currentPer > self.percent {
            self.stopAnimation()
            return
        }
        self.progressLayer.strokeEnd = CGFloat(self.currentPer / 100)
        self.percentLabel.text = "\(self.currentPer)%"
        self.currentPer += 1
    }
    
    @IBAction func textfiledChangedAction(_ sender: UITextField) {
        
        self.percent = Float(Int(sender.text!) ?? 0)
    }
    
    @IBAction func animationAction(_ sender: Any) {

        self.currentPer = 0.0
        if self.percent > 0 && self.percent < 100.0 {
            self.startAnimation()
        }
    }
    
    private func stopAnimation() {
        self.link.isPaused = true
    }
    private func startAnimation() {
        self.link.isPaused = false
    }
}
