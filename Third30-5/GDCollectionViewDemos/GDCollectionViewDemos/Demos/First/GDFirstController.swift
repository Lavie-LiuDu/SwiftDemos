//
//  GDFirstController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFirstController: UIViewController {

    
    @IBOutlet weak var firConllectionV: UICollectionView!
    @IBOutlet weak var firPageControl: UIPageControl!
    
    private let firCellID:String = "GDFirCollectionVCellID"
    private var dataSource:[String] = ["1", "2", "3", "4", "5", "6","7", "8","9", "10", "11", "12", "13", "14", "15", "16", "17", "18"]
    private var itemCount:Int = 0
    private var currentPage:Int = 0
    private var isScrol:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        
    }
    
    fileprivate func configUI() {
     
        self.firConllectionV.alwaysBounceHorizontal = true
        if dataSource.count % 8 == 0 {
            itemCount = dataSource.count
        }else{
            //MAKR:数量不足一屏补足一屏
            itemCount = (dataSource.count / 8 + 1) * 8
        }
        
        let count = dataSource.count % 8 == 0 ? dataSource.count / 8 : dataSource.count / 8 + 1
        self.firPageControl.currentPage = 0
        self.firPageControl.numberOfPages = count
    }
    
    @IBAction func clickPageControlAction(_ sender: UIPageControl) {
       
        let offSetX = CGFloat(sender.currentPage) * self.firConllectionV.bounds.width
        
        self.firConllectionV.contentOffset = CGPoint(x: offSetX, y: 0)
    }
    
}

extension GDFirstController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellone = collectionView.dequeueReusableCell(withReuseIdentifier: firCellID, for: indexPath) as! GDFirCollectionViewCell
        if indexPath.row < self.dataSource.count {
            cellone.countLabel.text = dataSource[indexPath.row]
            cellone.backgroundColor = UIColor.brown
        }else {
            cellone.backgroundColor = UIColor.white
            cellone.countLabel.text = ""
        }
        return cellone
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > scrollView.bounds.width / 2 {
            self.firPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        }
    }
}







