//
//  GDInfoCardlController.swift
//  MaillistDemo
//
//  Created by 熊笑明 on 2017/10/22.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDInfoCardlController: UIViewController {

    @IBOutlet weak var contactIco: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactModbile: UILabel!
    
    @IBOutlet weak var contactEmail: UILabel!
    
    @IBOutlet weak var contactNotes: UILabel!
    
    var contactModel:GDContactModel? {
        
        didSet{
            guard let contactModel = contactModel else {
                return
            }
            self.contactName.text = contactModel.name
            self.contactIco.image = UIImage(named: contactModel.headPortraitStr)
            self.contactEmail.text = contactModel.email
            self.contactNotes.text = contactModel.notes
            
            let showText = self.countNumAndChangeformat(text: (self.contactModel?.phone)!)
            self.contactModbile.text = showText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    private func countNumAndChangeformat(text:String) -> String {
        var temp = text
        let count = text.characters.count
        for index in 0..<count {
            if index == 3 {
                temp.insert("-", at:  String.Index.init(encodedOffset: index))
            }
            if index == 8 {
                temp.insert("-", at:  String.Index.init(encodedOffset: index))
            }
        }
        return temp
    }
    
}
