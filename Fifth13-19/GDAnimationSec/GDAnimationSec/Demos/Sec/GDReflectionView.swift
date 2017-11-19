//
//  GDReflectionView.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDReflectionView: UIImageView {

    override var layer: CALayer {
        return CAReplicatorLayer()
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
        //configure replicator
        let layer:CAReplicatorLayer = self.layer as! CAReplicatorLayer
        layer.instanceCount = 2
        
        //move reflection instance below original and flip vertically
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, self.bounds.height + 2, 0)
        transform = CATransform3DScale(transform, 1, 1, 0)
        layer.instanceTransform = transform
        
        //reduce alpha of reflection layer
        layer.instanceAlphaOffset = -0.6;
    }
}
