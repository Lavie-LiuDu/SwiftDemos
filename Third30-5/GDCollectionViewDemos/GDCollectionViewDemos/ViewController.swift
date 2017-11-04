//
//  ViewController.swift
//  GDCollectionViewDemos
//
//  Created by 熊笑明 on 2017/11/4.
//  Copyright © 2017年 Lavie. All rights reserved.
//
/*
 http://www.cocoachina.com/ios/20150623/12233.html
 Axis表示Stack View的subview是水平排布还是垂直排布。Alignment控制subview对齐方式。Distribution定义subview的分布方式。Spacing 为subview间的最小间距。
 
 把术语简化一下，你可这样理解：Alignment 用于控制X 和 Y值，而Distribution 用于控制高度和宽度。另两个值都会影响对齐。如果选中Baseline Relative将根据subview的基线调整垂直间距。如果选中Layout Margins Relative 将相对于标准边界空白来调整subview位置。
 另一个需要记住的是，Stack View会被当成Container View。所以它是一个不会被渲染的UIView子类。它不像其他UIView子类一样，会被渲染到屏幕上。这也意味着设置其backgroundColor属性或重载drawRect:方法都不会产生任何效果。
 
 Alignment 设为 Center
 Distribution 设为 Equal Spacing
 Spacing 设为 30
 这告诉Stack View为subview添加约束，使其垂直居中并沿Stack View的轴线对称，然后为subview设置边距30。
 如果subview大小和Stack View内容区不相符，将根据compression resistance priorities对subview进行拉伸或压缩。在运行时给Stack View添加subview也同样会如此。
 
 布局有任何歧义Stack View都会根据subview在arrangedSubviews中index一步步回退去调整subview的大小，直至其刚好适应Stack View的大小。
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)
    }
}

