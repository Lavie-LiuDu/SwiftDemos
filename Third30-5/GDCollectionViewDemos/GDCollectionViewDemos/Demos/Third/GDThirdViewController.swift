//
//  GDThirdViewController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit
import AVFoundation

class GDThirdViewController: UIViewController {
    
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    
    fileprivate lazy var dataSource:[UIImage] = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configData()
        self.configUI()
    }

    fileprivate func configUI() {
        
        let thirdLayout = GDThirdLayout()
        thirdLayout.delegate = self
        self.thirdCollectionView.collectionViewLayout = thirdLayout
    }
    
    fileprivate func configData() {
        
        for index in 1..<20 {
            let count = index % 8 == 0 ? 1 : index % 8
            let imageName = "demo2_" + "\(count)"
            let oneImage = UIImage(named: imageName)
            self.dataSource.append(oneImage!)
        }
    }
}

extension GDThirdViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellone = collectionView.dequeueReusableCell(withReuseIdentifier: "GDThirdCollectionViewCellID", for: indexPath) as! GDThirdCollectionViewCell
        cellone.thirdImageView.image = self.dataSource[indexPath.item]
        return cellone
    }
}

extension GDThirdViewController:GDThirdLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, HeightForItemAt indexPath: IndexPath) -> CGFloat {
        
        guard let layout = collectionView.collectionViewLayout as? GDThirdLayout else { return 0 }
        let img = dataSource[indexPath.row]
        let imgRect = CGRect(origin: .zero, size: CGSize.init(width: layout.cellWidth, height: CGFloat(MAXFLOAT)))
        let rect = AVMakeRect(aspectRatio: img.size, insideRect: imgRect)
        return rect.size.height
    }
}
