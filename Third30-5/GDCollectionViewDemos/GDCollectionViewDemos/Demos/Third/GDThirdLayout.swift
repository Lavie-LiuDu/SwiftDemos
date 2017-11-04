//
//  GDThirdLayout.swift
//  GDUICollectionViewDemos
//
//  Created by Lavie on 2017/10/30.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDThirdLayout: UICollectionViewLayout {

    var dataSource:[UIImage] = [UIImage]()
    var columnCount = 2
    fileprivate var totalHeight:[CGFloat] = [10, 10]
    fileprivate var itemCount = 0
    fileprivate var cellMargin:CGFloat = 10
    
    fileprivate var attributeAttay:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        self.itemCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        var indexPath:IndexPath
        for index in 0..<self.itemCount {
            indexPath = IndexPath(item: index, section: 0)
            let attribute = layoutAttributesForItem(at: indexPath)
            self.attributeAttay.append(attribute!)
        }
        
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)

        let itemW = ((self.collectionView?.bounds.size.width)!-cellMargin * CGFloat(columnCount)) / 2
        let itemH:CGFloat = dataSource[indexPath.row].size.height * itemW / dataSource[indexPath.row].size.width
        
        attribute.size = CGSize(width: itemW, height: itemH)

        var nub:CGFloat = 0
        var tempH:CGFloat = 0
        (nub,tempH) = minH(hhs: self.totalHeight)
        
        let centerX:CGFloat = (nub + 0.5)*(cellMargin + itemW)
        let centerY:CGFloat = tempH + itemH / 2
        print("centerX:\(centerX), centerY:\(centerY)")
        print("itemW:\(itemW), itemH:\(itemH)")

        attribute.center = CGPoint(x: centerX, y: centerY)
        
        self.totalHeight[Int(nub)] = tempH + itemH + cellMargin

        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.attributeAttay
    }
    
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (self.collectionView?.bounds.width)!, height: maxH(hhs: self.totalHeight))
        }
        set{
            self.collectionViewContentSize = newValue
        }
    }
   
    fileprivate func minH(hhs:[CGFloat])->(CGFloat,CGFloat){
        var num = 0
        var min = hhs[0]
        for i in 1..<hhs.count{
            if min>hhs[i] {
                min = hhs[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    fileprivate func maxH(hhs:[CGFloat])->CGFloat{
        var max = hhs[0]
        for i in 1..<hhs.count{
            if max<hhs[i] {
                max = hhs[i]
            }
        }
        return max
    }
}
