//
//  GDScrollViewBrower.swift
//  GDScrollviewBrower
//
//  Created by Lavie on 2017/10/24.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDScrollViewBrower: UIView {

    fileprivate lazy var scrollView:UIScrollView = {
       
        let scrollV = UIScrollView()
        scrollV.showsVerticalScrollIndicator = false
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.isPagingEnabled = true
        scrollV.frame = self.bounds
        return scrollV
    }()
    fileprivate var imageDatas:[String]

    init(frame: CGRect, imageDatas:[String]) {
        
        self.imageDatas = imageDatas
        super.init(frame: frame)
        configUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension GDScrollViewBrower {
   
    fileprivate func configUI() {
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(imageDatas.count), height: 0)
        self.addSubview(self.scrollView)
        
        self.configImageView()
    }
    private func configImageView() {
        
        let width = self.bounds.width
        let height = self.bounds.height
        let y:CGFloat = 0
        
        for (index, imageName) in self.imageDatas.enumerated() {
            
            let imageV = UIImageView()
            imageV.image = UIImage(named: imageName)
            imageV.frame = CGRect(x: width * CGFloat(index), y: y, width: width, height: height)
            imageV.tag = 1000 + index
            
            self.scrollView.addSubview(imageV)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(imageViewClick(_:)))
            imageV.isUserInteractionEnabled = true
            imageV.addGestureRecognizer(tapGes)
        }
    }
    
    @objc fileprivate func imageViewClick(_ tap:UITapGestureRecognizer) {
        
        print("你点击了:\(tap.view?.tag)张")
    }
}
