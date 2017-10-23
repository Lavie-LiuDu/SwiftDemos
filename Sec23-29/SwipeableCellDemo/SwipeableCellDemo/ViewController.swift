//
//  ViewController.swift
//  SwipeableCellDemo
//
//  Created by 熊笑明 on 2017/10/23.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

let cellID = "SwipeableCellID"


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var dataSource:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        configData()
    }

    fileprivate func configData() {
        dataSource.removeAll()
        for index in 0..<10 {
            let str = "第\(index + 1)行"
            dataSource.append(str)
        }
    }
    
    fileprivate func alertShow(title:String = "确认此操作吗？", complete:@escaping (()->())) {
        let alertV = UIAlertController(title: nil, message: title, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "YES", style: .default) { (action) in
             complete()
        }
        let cancleAction = UIAlertAction(title: "NO", style: .default) { (action) in
           
        }
        alertV.addAction(okaction)
        alertV.addAction(cancleAction)
        self.present(alertV, animated: true, completion: nil)
    }
    
    fileprivate func share() {
        
        let shareTitle = "share title"
        let shareImage = #imageLiteral(resourceName: "timg")
        let shareurl = "www.baidu.com"
//        let activiItems = [shareTitle, shareImage, shareurl]
        let activityV = UIActivityViewController(activityItems: [shareTitle, shareImage, shareurl], applicationActivities: nil)
        self.present(activityV, animated: true, completion: nil)
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellone = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cellone.textLabel?.text = dataSource[indexPath.row]
        cellone.imageView?.image = #imageLiteral(resourceName: "timg")
        return cellone
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) in
            self.dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = UIColor.gray
        
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (shareAction, indexPath) in
            
            self.alertShow {
                self.share()
            }
        }
        shareAction.backgroundColor = UIColor.red
        let downloadAction = UITableViewRowAction(style: .default, title: "Download") { (downloadAction, indexPath) in
            
            self.alertShow(title: "下载完成", complete: {
                
            })
        }
        downloadAction.backgroundColor = UIColor.blue
        
        return [ downloadAction, shareAction, deleteAction]
    }
}

