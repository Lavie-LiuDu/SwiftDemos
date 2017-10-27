//
//  GDAddToDoController.swift
//  GDTodolist
//
//  Created by Lavie on 2017/10/24.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit
import RealmSwift

let realm = try! Realm()

class GDAddToDoController: UIViewController {

    
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var datePickView: UIPickerView!
    @IBOutlet weak var hotelBtn: UIButton!
    @IBOutlet weak var humberBtn: UIButton!
    @IBOutlet weak var musleBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    
    fileprivate lazy var monthData:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    fileprivate lazy var yearData:[String] = {
        var arr = [String]()
        for index in 2010..<2050 {
            arr.append("\(index)")
        }
        return arr
    }()
    fileprivate lazy var dayData:[String] = [String]()
    fileprivate var dayCounts:Int = 0
    fileprivate var selectedRowYear:Int = 0
    fileprivate var selectedRowMonth:Int = 0
    fileprivate var selectedRowDay:Int = 0
    
    fileprivate var todoDate:String = "\(Date())"
    fileprivate var toDoTitleStr:String = ""
    fileprivate var todoTypeName:String = "hotel" {
        didSet{
            
            hotelBtn.setImage(#imageLiteral(resourceName: "hotel-gray"), for: .normal)
            humberBtn.setImage(#imageLiteral(resourceName: "humber-gray"), for: .normal)
            musleBtn.setImage(#imageLiteral(resourceName: "musle-gray"), for: .normal)
            messageBtn.setImage(#imageLiteral(resourceName: "message-gray"), for: .normal)
           
            if todoTypeName == "hotel" {
                hotelBtn.setImage(#imageLiteral(resourceName: "hotel"), for: .normal)
            }else if todoTypeName == "humber" {
                humberBtn.setImage(#imageLiteral(resourceName: "humber"), for: .normal)
            }else if todoTypeName == "musle" {
                musleBtn.setImage(#imageLiteral(resourceName: "musle"), for: .normal)
            }else{
                messageBtn.setImage(#imageLiteral(resourceName: "message"), for: .normal)
            }
            
        }
    }
    fileprivate var selectDate:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        initPickviewData()
      
    }
    private func initPickviewData() {
        let comp = Calendar.current.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: Date())
        self.configDayDataWith(comp.month!, year: comp.year!)
        
        self.selectedRowYear = comp.year! - 2010
        self.selectedRowMonth = comp.month! - 1
        self.selectedRowDay = comp.day! - 1
        self.datePickView.selectRow(self.selectedRowMonth, inComponent: 0, animated: true)
        self.datePickView.selectRow(self.selectedRowDay, inComponent: 1, animated: true)
        self.datePickView.selectRow(self.selectedRowYear, inComponent: 2, animated: true)

    }
    
    private func configDayDataWith(_ month:Int, year:Int) {

        let yearF:Int = year%4
        switch month {
        case 1:  dayCounts = 31; break
        case 2: dayCounts = yearF == 0 ? 29 : 28; break
        case 3:  dayCounts = 31; break
        case 4:  dayCounts = 30; break
        case 5:  dayCounts = 31; break
        case 6:  dayCounts = 30; break
        case 7:  dayCounts = 31; break
        case 8:  dayCounts = 31; break
        case 9:  dayCounts = 30; break
        case 10:  dayCounts = 31; break
        case 11:  dayCounts = 30; break
        case 12:  dayCounts = 31; break
        default :
            dayCounts = 31
            break
        }
        self.configDayData(counts: dayCounts)
    }
    private func configDayData(counts:Int) {
       
        self.dayData.removeAll()
        for index in 1...counts {
            self.dayData.append("\(index)")
        }
    }
    
    private func stringFromDate() {
     
        let year = self.selectedRowYear+2010
        let month = self.selectedRowMonth+1
        let day = self.selectedRowDay+1
        
        self.todoDate = "\(year)-\(month)-\(day)"
    }
    
    @IBAction func cancleAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        
        guard self.toDoTitleStr != "" else {
            return
        }
        self.stringFromDate()
        
        realm.beginWrite()
        realm.create(GDTodoModel.self, value: ["todoTypeImage":self.todoTypeName, "todoTitle":self.toDoTitleStr, "todoDate":self.todoDate])
        try! realm.commitWrite()
        
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func hotelAction(_ sender: UIButton) {
        
        self.todoTypeName = "hotel"
    }
   
    @IBAction func humberAction(_ sender: Any) {
        
        self.todoTypeName = "humber"
    }
    @IBAction func musleAction(_ sender: Any) {
        
        self.todoTypeName = "musle"
    }
    @IBAction func messageAction(_ sender: Any) {
        
        self.todoTypeName = "message"
    }
    @IBAction func todoTitleEditAction(_ sender: UITextField) {

        self.toDoTitleStr = sender.text ?? ""
    }
    
    @IBAction func tapAction(_ sender: Any) {
        self.todoTitle.resignFirstResponder()
    }
    
    
}
extension GDAddToDoController:UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return self.monthData.count
        }else if component == 1 {
            
            return self.dayData.count
        }else {
            return self.yearData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return 125
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return self.monthData[row]
        }else if component == 1{
            return self.dayData[row]
        }else {
            return self.yearData[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            self.selectedRowMonth = row
        }
        if component == 1 {
            self.selectedRowDay = row
        }
        if component == 2 {
            self.selectedRowYear = row
        }
        if component != 1 {
            self.configDayDataWith(self.selectedRowMonth + 1, year: self.selectedRowYear + 2010)
            pickerView.reloadComponent(1)
        }
    }
}
