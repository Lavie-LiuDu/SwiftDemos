//
//  GDClockController.swift
//  GDAnimationFirst
//
//  Created by Lavie on 2017/11/6.
//  Copyright © 2017年 Lavie. All rights reserved.
//
/*
 默认情况下position相当于UIView 的center
 position决定了layer在父上的位置。
 但是anchorPoint决定了position在自身的位置。
 anchorPoint的数值只能是0～1。所以是按照百分比计算的。
 
 */

import UIKit

class GDClockController: UIViewController {

    @IBOutlet weak var clock: UIImageView!
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var minuteView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    fileprivate lazy var clockTimer:Timer = {
        let timer = Timer(timeInterval: 1, target: self, selector: #selector(chapter3), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
        return timer
    }()
    fileprivate lazy var calink:CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(chapter3))
        return link
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configClock()
//        chapter1()
    }
    
    private func configClock() {

        self.hourView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.secondView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.minuteView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        self.hourView.center = self.clock.center
        self.minuteView.center = self.clock.center
        self.secondView.center = self.clock.center
        
//        self.clockTimer.fire()
        calink.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.clockTimer.invalidate()
        
    }

    //MARK:chapter 1-2
    private func chapter1() {
        
        let layer = CALayer()
        layer.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        layer.contents = #imageLiteral(resourceName: "clock").cgImage // must be cgimage
        layer.contentsGravity = kCAGravityResizeAspect
//        layer.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)  //Image sprites , LayerSprites framework
        //MAKR:其实就是拉伸
//        layer.contentsCenter = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
        self.clock.layer.addSublayer(layer)
    }
    
    @objc private func chapter3(){
     
        let calender = Calendar.current
        let hourcomponents = calender.component( Calendar.Component.hour, from: Date())
        let hourAngle:CGFloat = CGFloat(Double(hourcomponents) / 12.0 * .pi * 2.0)
        self.hourView.transform = CGAffineTransform(rotationAngle: hourAngle)
        
        let minutecomponents = calender.component( Calendar.Component.minute, from: Date())
        let minuteAngle:CGFloat = CGFloat(Double(minutecomponents) / 60.0 * .pi * 2.0)
        self.minuteView.transform = CGAffineTransform(rotationAngle: minuteAngle)

        let secondcomponents = calender.component( Calendar.Component.second, from: Date())
        let secondAngle:CGFloat = CGFloat(Double(secondcomponents) / 60.0 * .pi * 2.0)
        self.secondView.transform = CGAffineTransform(rotationAngle: secondAngle)

    }
    
    @objc func transformClock() {
        
    }
}
