//
//  GDTwitterViewController.swift
//  GDAnimationFirst
//
//  Created by Lavie on 2017/11/7.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDTwitterViewController: UIViewController {

    @IBOutlet weak var twitterView: UIImageView!
    
    fileprivate var maskLayer:CALayer = {
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x:0, y: 0, width: 100, height: 100)
        maskLayer.contents = #imageLiteral(resourceName: "twitter logo mask").cgImage
        return maskLayer
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.maskLayer.position = self.view.center
        //mask属性特点:内容非透明则可以显示,透明则隐藏.
        self.twitterView.layer.mask = self.maskLayer
        
        self.startAnimation()
    }
    
    func startAnimation() {
        
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        animation.duration = 1
        
        let initalBounds = self.maskLayer.frame
        let secondBounds = CGRect(x: 0, y: 0, width: 90, height: 90)
        let finalBounds = CGRect(x: 0, y: 0, width: 2000, height: 2000)
        
        animation.values = [initalBounds, secondBounds, finalBounds]
        animation.keyTimes = [0, 0.3, 1]
        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.maskLayer.add(animation, forKey: "bounds")
    }
    
}
