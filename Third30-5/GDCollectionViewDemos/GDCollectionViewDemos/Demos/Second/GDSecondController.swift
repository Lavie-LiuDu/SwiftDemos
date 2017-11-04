//
//  GDSecondController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDSecondController: UIViewController {

    fileprivate lazy var dataSource:[String] = ["demo2_1","demo2_2", "demo2_3", "demo2_4", "demo2_5", "demo2_6", "demo2_7", "demo2_8", "demo2_9", "demo2_10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "collectionView"
        self.navigationController?.navigationBar.backgroundColor = UIColor.yellow
    }

}

extension GDSecondController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellone = collectionView.dequeueReusableCell(withReuseIdentifier: "GDSecCollectionVCellID", for: indexPath) as! GDSecCollectionViewCell
        cellone.imageV.image = UIImage(named: self.dataSource[indexPath.item])
        return cellone
    }
}
