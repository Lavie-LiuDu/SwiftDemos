//
//  GDTodoModel.swift
//  GDTodolist
//
//  Created by Lavie on 2017/10/26.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit
import RealmSwift

class GDTodoModel: Object {

    @objc dynamic var todoTypeImage = ""
    @objc dynamic var todoTitle = ""
    @objc dynamic var todoDate:String = ""

}
