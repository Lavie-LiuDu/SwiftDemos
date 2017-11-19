//
//  GDScrollView.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDScrollView: UIView {

    override var layer: CALayer{
        return CAScrollLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
        
    }
    
    fileprivate func setUp() {
        let scrollLayer:CAScrollLayer = self.layer as! CAScrollLayer
        
        //enable clipping
        scrollLayer.masksToBounds = true
        
        //attach pan gesture recognizer
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(recognizer:)))
        self.addGestureRecognizer(recognizer)
    }

    @objc fileprivate func panAction(recognizer:UIPanGestureRecognizer) {
        
        //get the offset by subtracting the pan gesture
        //translation from the current bounds origin
        var offset = self.bounds.origin
        offset.x -= recognizer.translation(in: self).x
        offset.y -= recognizer.translation(in: self).y
        //scroll the layer
        let scrollLayer:CAScrollLayer = self.layer as! CAScrollLayer
        scrollLayer.scroll(to: offset)
        //reset the pan gesture translation
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self)
        
    }
}
