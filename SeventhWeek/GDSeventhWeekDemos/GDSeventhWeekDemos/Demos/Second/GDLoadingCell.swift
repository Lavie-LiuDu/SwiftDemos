//
//  GDLoadingCell.swift
//  GDSevenWeekDemos
//
//  Created by Lavie on 2017/11/28.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDLoadingCell: UICollectionViewCell {
    
    fileprivate lazy var imageView:UIImageView = {
        let iamgeV = UIImageView(frame: self.contentView.frame)
        iamgeV.contentMode = .scaleAspectFill
        iamgeV.clipsToBounds = true
        iamgeV.image = #imageLiteral(resourceName: "show_def_local")
        return iamgeV
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageUrl:String? {
        didSet{
            guard let imageUrl = imageUrl else {
                return
            }
            self.imageView.image = #imageLiteral(resourceName: "show_def_local")
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: URL(string: imageUrl)!)
                DispatchQueue.main.async(execute: {[weak self] in
                    if let data = data {
                        self?.imageView.image = UIImage(data: data)
                    }
                })
            }
        }
    }
    
    
}

extension GDLoadingCell {
    
    class func creatCell(collectionV:UICollectionView, indexpath:IndexPath) -> GDLoadingCell {
      
        let cell = collectionV.dequeueReusableCell(withReuseIdentifier: cellID, for: indexpath) as! GDLoadingCell
        
        return cell
    }
    
}
