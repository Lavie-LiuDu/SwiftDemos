//
//  ViewController.swift
//  GDRegionaldivision
//
//  Created by Lavie on 2017/10/18.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit
let cellID = "GDRegionaldivisionCellID"


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var currentSection:Int = -1
    fileprivate var currentIndex:Int = -1
    
    fileprivate var threeDatas = [[["   北京", "   上海", "   杭州", "   广州", "   厦门"], ["   莫斯科", "   叶卡捷琳堡", "   下诺夫哥罗德", "   罗斯托夫"]], [["   悉尼", "   墨尔本", "   堪培拉"]],[["   纽约", "   华盛顿", "   洛杉矶"], ["   多伦多", "   渥太华"]], [["   伦敦", "    伯明翰", "   利兹", "   曼彻斯特"], ["   马德里", "   巴塞罗那", "   塞维利亚"], ["   巴黎", "   里昂"]]]
    fileprivate var twoDats = [["中国","俄罗斯"],[ "澳大利亚"],[ "美国", "加拿大"], ["英国", "西班牙", "法国"]]
    fileprivate var oneDatas = ["亚洲", "澳洲","北美洲", "欧洲"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    @objc func didSelectSectionView(sender:UIButton) {
        
        let section = sender.tag - 100
        if currentSection != -1 {
            currentIndex = -1
            currentSection = -1
        }else{
            currentSection = section
        }
        self.tableView.reloadData()
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return oneDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentSection == -1 {
            return 0
            
        }else{
            if currentSection == section {
                if currentIndex != -1{
                    
                    return threeDatas[currentSection][currentIndex].count + twoDats[currentSection].count
                    
                }else{
                    return twoDats[currentSection].count
                }
                
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellone = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cellone.backgroundColor = UIColor.lightGray
        
        if currentSection == indexPath.section {
            if currentIndex == -1 {
                cellone.textLabel?.text = twoDats[currentSection][indexPath.row]
                cellone.detailTextLabel?.text = "+"
            }else{
                if indexPath.row <= currentIndex {
                    cellone.textLabel?.text = twoDats[currentSection][indexPath.row]
                    cellone.detailTextLabel?.text = "+"
                }else{
                    if indexPath.row - currentIndex - 1 < threeDatas[currentSection][currentIndex].count {
                        cellone.backgroundColor = UIColor.white
                        cellone.textLabel?.text = threeDatas[currentSection][currentIndex][indexPath.row - currentIndex - 1]
                        cellone.detailTextLabel?.text = "-"
                    }else{
                        cellone.textLabel?.text = twoDats[currentSection][indexPath.row - threeDatas[currentSection][currentIndex].count]
                        cellone.detailTextLabel?.text = "+"
                    }
                }
            }
        }
        return cellone
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderV = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        sectionHeaderV.textLabel?.text = oneDatas[section]
        sectionHeaderV.accessoryType = .disclosureIndicator
        sectionHeaderV.backgroundColor = UIColor.gray
        let btn = UIButton(type: .system)
        btn.tag = section + 100
        btn.frame = sectionHeaderV.bounds
        btn.addTarget(self, action: #selector(didSelectSectionView(sender:)), for: .touchUpInside)
        sectionHeaderV.contentView.addSubview(btn)
        return sectionHeaderV
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //MARK:强制收起
        if currentIndex != -1 {
            currentIndex = -1
        }else{
            currentIndex = indexPath.row
        }
        self.tableView.reloadData()
    }
    
}
