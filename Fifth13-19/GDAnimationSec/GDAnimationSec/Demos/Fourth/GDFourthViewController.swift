//
//  GDFourthViewController.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFourthViewController: UIViewController {
    

    fileprivate lazy var loadingView:GDLodingView = {
       let loadingV = GDLodingView(frame: CGRect(x: 150, y: 200, width: 80, height: 80))
        return loadingV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(loadingView)
        
        self.loadingView.startAnimation()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.loadingView.stopAnimation()
    }

}
