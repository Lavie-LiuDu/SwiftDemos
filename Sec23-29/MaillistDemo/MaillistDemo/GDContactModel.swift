//
//  GDContactModel.swift
//  MaillistDemo
//
//  Created by 熊笑明 on 2017/10/22.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class GDContactModel: NSObject {

    var name:String = ""
    var headPortraitStr:String = ""
    var phone:String = ""
    var email:String = ""
    var notes:String = ""
    

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
        if key == "headPortraitStr" {
            self.headPortraitStr = value as! String
        }
        if key == "name" {
            self.name = value as! String
        }
        if key == "phone" {
            self.phone = value as! String
        }
        if key == "email" {
            self.email = value as! String
        }
        if key == "notes" {
            self.notes = value as! String
        }
        
    }
}
