//
//  GDTransitionViewController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/31.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDTransitionViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var traniitionimageV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop {
            return GDFifthPopAnimation()
        }
        return nil
        
    }
}
