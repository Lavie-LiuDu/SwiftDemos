//
//  GDFifthViewController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFifthViewController: UIViewController {

    @IBOutlet weak var fifthCollectionView: UICollectionView!
    
    fileprivate let dataSource:[String] = ["1", "2", "3", "4", "5", "6"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
extension GDFifthViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellone = collectionView.dequeueReusableCell(withReuseIdentifier: "GDFifthViewCellID", for: indexPath) as! GDFifthCollectionViewCell
        cellone.iconImageV.image = UIImage(named: self.dataSource[indexPath.row])
        return cellone
    }
}

