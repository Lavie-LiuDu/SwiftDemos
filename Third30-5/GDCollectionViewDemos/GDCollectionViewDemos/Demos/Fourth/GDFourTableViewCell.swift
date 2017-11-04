//
//  GDFourTableViewCell.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFourTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectColorV: UIView!
    
    var isSelectIndex:Bool = false{
        didSet{
            self.selectColorV.isHidden = !isSelectIndex
            self.contentView.backgroundColor = isSelectIndex ? UIColor.lightGray : UIColor.white
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
