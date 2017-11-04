//
//  GDFourthViewController.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDFourthViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    fileprivate let leftDataSource:[String] = ["龙虾类","蟹类", "贝类","其他活鲜", "冻品"]
    fileprivate let detailDataSource:[String] = ["加拿大龙虾", "上海螃蟹", "好望角贝壳", "海里的", "水饺"]
    fileprivate var detailNameChange:String = "加拿大龙虾"
    fileprivate var currentSelectIndex:Int = 0 {
        didSet{
            self.detailNameChange = detailDataSource[currentSelectIndex]
            self.detailCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

}

extension GDFourthViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.leftDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellon = tableView.dequeueReusableCell(withIdentifier: "GDFourthTableViewCellID", for: indexPath) as! GDFourTableViewCell
        cellon.nameLabel.text = self.leftDataSource[indexPath.row]
        cellon.isSelectIndex = self.currentSelectIndex == indexPath.row
        return cellon
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.currentSelectIndex = indexPath.row
        self.titleLabel.text = self.leftDataSource[indexPath.row]
        self.leftTableView.reloadData()
    }
}

extension GDFourthViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellone = collectionView.dequeueReusableCell(withReuseIdentifier: "GDFoourthCollectionViewCellID", for: indexPath) as! GDFourthCollectionViewCell
        cellone.nameLabel.text = self.detailNameChange
        return cellone
    }
}
