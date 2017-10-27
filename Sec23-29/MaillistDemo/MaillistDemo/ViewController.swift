//
//  ViewController.swift
//  MaillistDemo
//
//  Created by 熊笑明 on 2017/10/22.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactTableV: UITableView!
    
    fileprivate lazy var contactDataS = [GDContactModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.configData()
        self.contactTableV.reloadData()
    }

    fileprivate func configData() {
        
        let path : NSString = Bundle.main.path(forResource: "Contacts", ofType: "plist")! as NSString
        let dataDic = NSDictionary(contentsOfFile: path as String)
        
        for data in dataDic! {
            guard let contactList = data.value as? Array<Any> else{
                return
            }
            for contact in contactList {
                guard let con = contact as? [String : Any] else{
                    return
                }
                let contactModel = GDContactModel()
                contactModel.setValuesForKeys(con)
                self.contactDataS.append(contactModel)
            }
        }
    }

    
}
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactDataS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellone = tableView.dequeueReusableCell(withIdentifier: "GDContactCellID", for: indexPath) as! GDContactCell
        cellone.contactModel = self.contactDataS[indexPath.row]
        
        return cellone
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoCard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GDInfoCardVCID") as! GDInfoCardlController
        infoCard.view.backgroundColor = UIColor.white
        infoCard.contactModel = self.contactDataS[indexPath.row]
        self.navigationController?.pushViewController(infoCard, animated: true)
    }
}

