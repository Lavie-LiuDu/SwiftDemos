//
//  ViewController.swift
//  GDTodolist
//
//  Created by Lavie on 2017/10/24.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit
import RealmSwift

let cellID = "GDToDoCellID"

class ViewController: UIViewController {
    
    
    fileprivate var notificationToken: NotificationToken?
    fileprivate let results = try! Realm().objects(GDTodoModel.self)
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configData()
        configUI()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.todoTableView.setEditing(editing, animated: animated)
    }
    
    fileprivate func configUI() {
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    fileprivate func configData()  {
        
        self.notificationToken = try! Realm().objects(GDTodoModel.self).addNotificationBlock({ (change) in
            switch change {
            case .initial:
                self.todoTableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.todoTableView.beginUpdates()
                self.todoTableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.todoTableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.todoTableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.todoTableView.endUpdates()
                
            case .error(let err):
                fatalError("\(err)")
            }
            
        })
    }
    
}
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellone = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cellone == nil {
            cellone = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        let obj = results[indexPath.row]
        cellone?.imageView?.image = UIImage(named: obj.todoTypeImage)
        cellone?.textLabel?.text = obj.todoTitle
        cellone?.detailTextLabel?.text = obj.todoDate
        
        return cellone!
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //        let model = results[sourceIndexPath.row]
        //        realm.beginWrite()
        //        realm.delete(results[sourceIndexPath.row])
        //        realm.add(model)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            realm.beginWrite()
            realm.delete(results[indexPath.row])
            try! realm.commitWrite()
        }
        
    }
}

