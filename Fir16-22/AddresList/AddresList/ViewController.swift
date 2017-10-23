//
//  ViewController.swift
//  AddresList
//
//  Created by 熊笑明 on 2017/10/14.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

let CellID = "AddressCellID"


class ViewController: UIViewController {

    
    @IBOutlet weak var addTableView: UITableView!
    
    fileprivate lazy var addressPlist:[String:[String]] =  ["A":["AA","Ann","Ane","Al"], "B":["Baby", "Bob","Beck"], "C":["Cacy","Caclvin","Cucci"],"D":["David"],"E":["Edison", "Eney", "Ena"],"J":["Jennifer", "Jacy", "Jane", "Jack"],"L":["Leo", "Lily", "Lemon"],"S":["Sam","Susan","Sun", "Sunny", "Susu"],"Z":["ZZ"]]
    fileprivate var addressKeys:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addressKeys = [String](addressPlist.keys)
        self.addTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.addressKeys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = self.addressKeys![section]
        return self.addressPlist[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellone = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        let values = self.addressPlist[self.addressKeys![indexPath.section]]
        cellone.textLabel?.text = values?[indexPath.row]
        return cellone
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.addressKeys?[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return self.addressKeys
    }
}
