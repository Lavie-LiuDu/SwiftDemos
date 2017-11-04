//
//  GDSecCollectionViewCell.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDSecCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageV.layer.cornerRadius = 10
        self.imageV.layer.masksToBounds = true
    }
    
}

