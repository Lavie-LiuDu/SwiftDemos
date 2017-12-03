//
//  GDDynamicsViewController.swift
//  GDSevenWeekDemos
//
//  Created by Lavie on 2017/11/27.
//  Copyright © 2017年 Lavie. All rights reserved.
//
/*
 UIAttachmentBehavior：附着行为
 
 UICollisionBehavior：碰撞行为
 
 UIGravityBehavior：重力行为
 
 UIDynamicItemBehavior：动态元素行为
 
 UIPushBehavior：推行为
 
 UISnapBehavior：吸附行为
 */

import UIKit

class GDDynamicsViewController: UIViewController {

    fileprivate var myAnimator:UIDynamicAnimator?
    fileprivate var attachmentBehavior:UIAttachmentBehavior?
    fileprivate var gravityBehavior:UIGravityBehavior?
    fileprivate var collisionBehavior:UICollisionBehavior?
    fileprivate var snapBehavior:UISnapBehavior?
    
    fileprivate lazy var items:[UIImageView] = {

        var items = [UIImageView]()
        for index in 0..<5 {
            let item = UIImageView(image: #imageLiteral(resourceName: "ball"))
            item.frame = CGRect(x: 187, y: 333.5 + CGFloat(40 * index), width: 40, height: 40)
            items.append(item)
        }
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in items {
            self.view.addSubview(item)
        }
        self.configTap()
        self.configAnimator()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        myAnimator?.removeAllBehaviors()
    }
    fileprivate func configTap() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(tapHandler(pan:)))
        self.view.addGestureRecognizer(pan)
        
    }
    
    fileprivate func configAnimator() {
        
        myAnimator = UIDynamicAnimator(referenceView: self.view)
        myAnimator?.delegate = self
        gravityBehavior = UIGravityBehavior(items: items)
        gravityBehavior?.gravityDirection = CGVector(dx: 0, dy: 1.0)
        myAnimator?.addBehavior(gravityBehavior!)
        collisionBehavior = UICollisionBehavior(items: items)
        collisionBehavior?.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior?.collisionDelegate = self
        myAnimator?.addBehavior(collisionBehavior!)
        
        for (index, item) in items.enumerated() {
            let behavior = UIDynamicItemBehavior()
            behavior.elasticity = 0.8
            behavior.friction = 0.2
            behavior.resistance = 0.3
            behavior.density = 0.3
            behavior.angularResistance = 0.2
            behavior.addItem(item)
            if index != 0 {
                let attach = UIAttachmentBehavior(item: item, attachedTo: items[index - 1])
                myAnimator?.addBehavior(attach)
            }
            myAnimator?.addBehavior(behavior)
        }
    }
    
    @objc fileprivate func tapHandler(pan:UIPanGestureRecognizer) {
        
        switch pan.state {
        case .began:
        
            let anchor = pan.location(in: self.view)
            attachmentBehavior = UIAttachmentBehavior(item: items.first!, offsetFromCenter: UIOffsetMake(0, -40), attachedToAnchor: anchor)
            attachmentBehavior?.length = 10
            attachmentBehavior?.damping = 0.5
            myAnimator?.addBehavior(attachmentBehavior!)
            break
        case .changed:
            attachmentBehavior?.anchorPoint = pan.location(in: self.view)
            break
        case.ended:
            if attachmentBehavior != nil {
                myAnimator?.removeBehavior(attachmentBehavior!)
            }
            break
        default:
            break
        }
    }
    
    
    fileprivate func configSnapBehavior() {
        
        for (index, imageV) in items.enumerated() {
            if index != 0 {
                snapBehavior = UISnapBehavior(item: imageV, snapTo: CGPoint(x: items[index - 1].center.x, y: items[index - 1].center.y + 30))
                snapBehavior?.damping = 0.5
                myAnimator?.addBehavior(snapBehavior!)
            }
        }
    }
}



extension GDDynamicsViewController:UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate {
    
    
    
}

