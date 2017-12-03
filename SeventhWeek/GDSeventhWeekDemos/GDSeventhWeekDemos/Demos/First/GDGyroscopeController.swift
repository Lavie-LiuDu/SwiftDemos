//
//  GDGyroscopeController.swift
//  GDSevenWeekDemos
//
//  Created by Lavie on 2017/11/27.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit
import CoreMotion

class GDGyroscopeController: UIViewController {

    fileprivate var speedX:Double = 0
    fileprivate var speedY:Double = 0
    fileprivate lazy var ball:UIImageView = {
        let ball = UIImageView(image: #imageLiteral(resourceName: "timg"))
        ball.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        ball.center = self.view.center
        return ball
    }()
    fileprivate var motionManager:CMMotionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.ball)
        
        motionManager.accelerometerUpdateInterval = 1/60
        configBall()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        motionManager.stopAccelerometerUpdates()
    }

    fileprivate func configBall() {
        
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (accelerometerData, error) in
              
                //动态设置小球位置
                self.speedX += accelerometerData!.acceleration.x
                self.speedY +=  accelerometerData!.acceleration.y
                var posX=self.ball.center.x + CGFloat(self.speedX)
                var posY=self.ball.center.y - CGFloat(self.speedY)
                //碰到边框后的反弹处理
                if posX<0 {
                    posX=0;
                    //碰到左边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.01
                    
                }else if posX > self.view.bounds.size.width {
                    posX=self.view.bounds.size.width
                    //碰到右边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.01
                }
                if posY<0 {
                    posY=0
                    //碰到上面的边框不反弹
                    self.speedY=0
                } else if posY>self.view.bounds.size.height{
                    posY=self.view.bounds.size.height
                    //碰到下面的边框以1.5倍的速度反弹
                    self.speedY *= -0.1
                }
                self.ball.center = CGPoint(x:posX, y:posY)
            })
        }
        
    }
    
    

}
