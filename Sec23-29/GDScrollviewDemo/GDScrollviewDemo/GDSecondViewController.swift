//
//  GDSecondViewController.swift
//  GDScrollviewBrower
//
//  Created by Lavie on 2017/10/24.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageDatas = ["one", "two", "three", "four", "five"]
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        let scrolV = GDScrollViewBrower(frame: frame, imageDatas: imageDatas)
        self.view.addSubview(scrolV)
       
    }
    

}
