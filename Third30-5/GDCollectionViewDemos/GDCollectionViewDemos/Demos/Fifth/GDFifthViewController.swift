//
//  GDFifthViewController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFifthViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var fifthCollectionView: UICollectionView!
    
    fileprivate let dataSource:[String] = ["1", "2", "3", "4", "5", "6"]
   
    fileprivate lazy var transistionVC:GDTransitionViewController = {
        let transistionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GDTransitionVCID")
        
        return transistionVC as! GDTransitionViewController
    }()
    
    var selectedCell:GDFifthCollectionViewCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return GDFifthPushAnimation()
        }
        return nil
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedCell = (collectionView.cellForItem(at: indexPath) as! GDFifthCollectionViewCell)
        
        self.transistionVC.view.backgroundColor = UIColor.lightGray
        self.transistionVC.traniitionimageV.image = selectedCell?.iconImageV.image
        
        self.navigationController?.pushViewController(self.transistionVC, animated: true)
    }
}



