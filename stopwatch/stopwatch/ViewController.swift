//
//  ViewController.swift
//  stopwatch
//
//  Created by 熊笑明 on 2017/10/14.
//  Copyright © 2017年 Lavie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeShowLabel: UILabel!
    
    fileprivate var timer:Timer?
    fileprivate var timerValue:Float = 0.0
    {
        didSet{
            self.timeShowLabel.text = "\(timerValue)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }


    @IBAction func resetAction(_ sender: UIButton) {
    
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
        self.timerValue = 0.0
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        configTimer()
    }
    
    
    @IBAction func pauseAction(_ sender: UIButton) {
       
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
    }
    
    fileprivate func configTimer() {
        if timer == nil {
            timer = Timer(timeInterval: 0.2, target: self, selector: #selector(timerActionWithChangeTime), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        }
        timer?.fire()
    }
    
    @objc func timerActionWithChangeTime() {

        timerValue = timerValue + 0.1
        
    }
}

