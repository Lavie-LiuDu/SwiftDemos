//
//  GDLoadImageController.swift
//  GDSevenWeekDemos
//
//  Created by Lavie on 2017/11/27.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

let cellID:String = "GDLoadingImageCellID"

class GDLoadImageController: UIViewController {

    @IBOutlet weak var loadImageCollectionView: UICollectionView!
    
    
    fileprivate lazy var dataSource:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImageCollectionView.register(GDLoadingCell.self, forCellWithReuseIdentifier: cellID)
        configData()
    }
    
    func configData() {
        
        for index in 0..<20 {
            var str = ""
            if index % 3 == 0 {
                str = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511859995957&di=0cd22462c7f32838efff006aa45e9d1a&imgtype=0&src=http%3A%2F%2Fimg.gmz88.com%2Fuploads%2Fshouyou%2F2017%2F04%2F08%2F20170408114910359.jpg"
            }else if index % 5 == 0{
                str = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511860035966&di=49c8d5eb7c6aec3f1ba523da70e5ac08&imgtype=0&src=http%3A%2F%2Fwww.xz7.com%2Fup%2F2017-4%2F2017040111522439033.jpg"
            }else{
                str = "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1511849985&di=53ee58b1c546620e7667f4b1a2b2d5c9&src=http://www.wed114.cn/jiehun/uploads/allimg/161215/41_161215114800_3.jpg"
            }
            
            dataSource.append(str)
        }
        self.loadImageCollectionView.reloadData()
    }
}
extension GDLoadImageController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = GDLoadingCell.creatCell(collectionV: collectionView, indexpath: indexPath)
        cell.imageUrl = dataSource[indexPath.item]
        return cell
    }
    
}


