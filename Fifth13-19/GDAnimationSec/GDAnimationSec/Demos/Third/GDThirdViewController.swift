//
//  GDThirdViewController.swift
//  GDAnimationSecond
//
//  Created by Lavie on 2017/11/13.
//  Copyright © 2017年 Lavie. All rights reserved.
//
/*
 在第二章中，我们探索了图层的 contentsRect 属性的用法，它的确是能够解决 在图层中小地方显示大图片的解决方法。但是如果你的图层包含子图层那它就不是 一个非常好的解决方案，因为，这样做的话每次你想『滑动』可视区域的时候，你 就需要手工重新计算并更新所有的子图层位置。
 这个时候就需要CAScrollLayer了

 Core Animation并不处理用户输入，所以`CAScrollLayer`并不负责将触摸事件转换为滑动事件，既不渲染滚动条，也不实现任何iOS指定行为例如滑动反弹（当视图滑动超多了它的边界的将会反弹回正确的地方）。
 让我们来用`CAScrollLayer`来常见一个基本的`UIScrollView`替代品。我们将会用`CAScrollLayer`作为视图的宿主图层，并创建一个自定义的`UIView`，然后用`UIPanGestureRecognizer`实现触摸事件响应。
 
 
 ##CATiledLayer
 有些时候你可能需要绘制一个很大的图片，常见的例子就是一个高像素的照片或者是地球表面的详细地图。iOS应用通畅运行在内存受限的设备上，所以读取整个图片到内存中是不明智的。载入大图可能会相当地慢，那些对你看上去比较方便的做法（在主线程调用`UIImage`的`-imageNamed:`方法或者`-imageWithContentsOfFile:`方法）将会阻塞你的用户界面，至少会引起动画卡顿现象。
 能高效绘制在iOS上的图片也有一个大小限制。所有显示在屏幕上的图片最终都会被转化为OpenGL纹理，同时OpenGL有一个最大的纹理尺寸（通常是2048\*2048，或4096\*4096，这个取决于设备型号）。如果你想在单个纹理中显示一个比这大的图，即便图片已经存在于内存中了，你仍然会遇到很大的性能问题，因为Core Animation强制用CPU处理图片而不是更快的GPU
 CATiledLayer`为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。让我们用实验来证明一下
 
 在实际应用中，当一个视图被改动过了，TA可能需要重绘。但是很多情况下，只是这个视图的一部分被改变了，所以重绘整个寄宿图就太浪费了。但是Core Animation通常并不了解你的自定义绘图代码，它也不能自己计算出脏区域的位置。然而，你的确可以提供这些信息。 当你检测到指定视图或图层的指定部分需要被重绘，你直接调用-setNeedsDisplayInRect:来标记它，然后将影响到的矩形作为参数传入。这样就会在一次视图刷新时调用视图的-drawRect:（或图层代理的-drawLayer:inContext:方法）。 传入-drawLayer:inContext:的CGContext参数会自动被裁切以适应对应的矩形。为了确定矩形的尺寸大小，你可以用CGContextGetClipBoundingBox()方法来从上下文获得大小。调用-drawRect()会更简单，因为CGRect会作为参数直接传入。 你应该将你的绘制工作限制在这个矩形中。任何在此区域之外的绘制都将被自动无视，但是这样CPU花在计算和抛弃上的时间就浪费了，实在是太不值得了。 相比依赖于Core Graphics为你重绘，裁剪出自己的绘制区域可能会让你避免不必要的操作。那就是说，如果你的裁剪逻辑相当复杂，那还是让Core Graphics来代劳吧，记住：当你能高效完成的时候才这样做。 清单13.4 展示了一个-addBrushStrokeAtPoint:方法的升级版，它只重绘当前线刷的附近区域。另外也会刷新之前线刷的附近区域，我们也可以用CGRectIntersectsRect()来避免重绘任何旧的线刷以不至于覆盖已更新过的区域。这样做会显著地提高绘制效率（见图13.4
 */

import UIKit
import AVKit
//AVPlayerLayer
class GDThirdViewController: UIViewController {

    @IBOutlet weak var videoPlayeView: UIView!
    
    fileprivate var avplayer:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startPlay()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.avplayer != nil {
            self.avplayer?.pause()
            self.avplayer?.replaceCurrentItem(with: nil)
            self.avplayer = nil
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func startPlay() {
        
        if avplayer == nil {
    
            let path = Bundle.main.path(forResource: "qidong", ofType: "mp4")
            let url = URL(fileURLWithPath: path!)
            let playerItem = AVPlayerItem(url: url)
            avplayer = AVPlayer(playerItem: playerItem)

            let layer = AVPlayerLayer(player: avplayer)
            layer.videoGravity = .resizeAspectFill
            layer.frame = self.view.bounds
            self.videoPlayeView.layer.addSublayer(layer)
        }
        
        avplayer?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(endVideoToRepeat), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

    }
    @objc fileprivate func endVideoToRepeat() {
        
        guard avplayer != nil else {
            return
        }
        avplayer?.seek(to: kCMTimeZero)
        avplayer?.play()
    }
}
