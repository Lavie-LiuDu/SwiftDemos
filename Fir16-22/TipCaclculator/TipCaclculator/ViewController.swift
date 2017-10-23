//
//  ViewController.swift
//  TipCaclculator
//
//  Created by 熊笑明 on 2017/10/14.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterFare: UITextField!
    
    @IBOutlet weak var tipsPercent: UILabel!
    
    @IBOutlet weak var tipFare: UILabel!
    
    @IBOutlet weak var totalFare: UILabel!
    
    //MARK: defalut 15%
    fileprivate var tipPercentValue:Int = 15 {
        didSet{
            self.tipsPercent.text = "tips(%\(tipPercentValue))"
        }
    }
    fileprivate var enterFareValue:Int = 0
    fileprivate var totalFareValue:Float = 0 {
        didSet{
            self.totalFare.text = "\(totalFareValue)"
        }
    }
    fileprivate var tipFareValue:Float = 0 {
        didSet{
            self.tipFare.text = "\(tipFareValue)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    
    @IBAction func enterFareChangedAction(_ sender: UITextField) {
        
        enterFareValue = Int(sender.text ?? "0") ?? 0
        tipFareValue = Float(enterFareValue ) * Float(tipPercentValue)
        totalFareValue = tipFareValue + Float(enterFareValue )
        
        print("sender.text:\(String(describing: sender.text))")

    }
    
    @IBAction func changeTipPercentAction(_ sender: UISlider) {
        
        tipPercentValue = Int(sender.value)
        tipFareValue = Float(enterFareValue ) * Float(tipPercentValue)
        totalFareValue = tipFareValue + Float(enterFareValue)

        
        print("sender.value:\(Int(sender.value))")
    }
    

}

