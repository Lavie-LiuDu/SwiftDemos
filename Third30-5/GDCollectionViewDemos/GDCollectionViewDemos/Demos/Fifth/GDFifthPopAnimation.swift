//
//  GDFifthPopAnimation.swift
//  GDCollectionViewDemos
//
//  Created by 熊笑明 on 2017/11/5.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFifthPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 设置动画的进行方式
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from) as! GDTransitionViewController
        let toVC = transitionContext.viewController(forKey: .to) as! GDFifthViewController
        
        let containerView = transitionContext.containerView
        let snapshotView = fromVC.traniitionimageV.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert(fromVC.traniitionimageV.frame, from: fromVC.view)
        fromVC.traniitionimageV.isHidden = true
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.selectedCell?.iconImageV.isHidden = true
        toVC.view.alpha = 0
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            
            snapshotView?.frame = containerView.convert((toVC.selectedCell?.iconImageV.frame)!, from: toVC.selectedCell)
            toVC.view.alpha = 1.0
            
        }) { (finished) in
            
            toVC.selectedCell?.iconImageV.isHidden = false
            snapshotView?.removeFromSuperview()
            fromVC.traniitionimageV.isHidden = false
            transitionContext.completeTransition(true)
        }
    }
}
