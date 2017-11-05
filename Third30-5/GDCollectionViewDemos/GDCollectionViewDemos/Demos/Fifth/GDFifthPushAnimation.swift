//
//  GDFifthPushAnimation.swift
//  GDCollectionViewDemos
//
//  Created by 熊笑明 on 2017/11/5.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFifthPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 设置动画的进行方式
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from) as! GDFifthViewController
        let toVC = transitionContext.viewController(forKey: .to) as! GDTransitionViewController
        
        let containerView = transitionContext.containerView
        let snapshotView = fromVC.selectedCell?.iconImageV.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert((fromVC.selectedCell?.iconImageV.frame)!, from: fromVC.selectedCell)
        fromVC.selectedCell?.iconImageV.isHidden = true
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.traniitionimageV.isHidden = true
        toVC.view.alpha = 0
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView!)
        
        toVC.traniitionimageV.layoutIfNeeded()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            
            snapshotView?.frame = toVC.traniitionimageV.frame
            toVC.view.alpha = 1.0
            
        }) { (finished) in
            
            fromVC.selectedCell?.iconImageV.isHidden = false
            toVC.traniitionimageV.isHidden = false
            snapshotView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
