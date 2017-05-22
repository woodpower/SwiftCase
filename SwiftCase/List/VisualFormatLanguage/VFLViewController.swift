//
//  VFLViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/5/20.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

class VFLViewController: UIViewController {

    /**
     ----------------------------------------------------------------
     设置颜色时凌乱了，特研究了一下色彩理论：
     
     原色：能够以一定的比例调配出其它颜色的颜色
     
     加色系：以RedGreenBlue为原色的色彩体系。主动发光的物体发出来的颜色使用加色系，如太阳、火焰、灯、显示屏等。颜色越多越白。
     
     减色系：以CyneMegatonYellow为原色的色彩体系。不会主动发光，而是发射其它光线的物体，使用减色系，如月亮、纸张、油画笔等。颜色越多越黑。
     
     计算机中颜色表示法——加色系：任意一个颜色都要使用Red、Green、Blue三个原色以一定的比例混合调配出来。
     
     32(2^24)位真彩色：使用8bit(0-255/00-FF)来描述一个原色的配比量
     
     64(2^48)位真彩色：使用16bit(0-65535/0000-FFFF)来描述一个原色的配比量
     
     255,0,0            红色
     0,255,0            绿色
     0,0,255            蓝色
     0,0,0              黑色
     255,255,255        白色
     10,10,10           深灰色
     200,200,200        浅灰色
     0,255,255          青色，红色的互补色
     255,0,255          品红，绿色的互补色
     255,255,0          黄色，蓝色的互补色
     230,180,10         土黄色
     200,230,190
     
     和谐色：
     180 240 50
     240 180 50
     180 50 240
     240 50 180
     50 240 180
     50 180 240
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        let view1 = UIView()
        view1.backgroundColor = UIColor(red: 0.7, green: 0.3, blue: 0.95, alpha: 1.0)
        self.view.addSubview(view1)
        
        let view2 = UIView()
        view2.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.95, alpha: 1.0)
        self.view.addSubview(view2)
        
        let view3 = UIView()
        view3.backgroundColor = UIColor(red: 0.95, green: 0.3, blue: 0.7, alpha: 1.0)
        self.view.addSubview(view3)
        
        // 先添加到父视图中，关闭autoresizing，再进行布局
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        view3.translatesAutoresizingMaskIntoConstraints = false
        
        /**
         VFL：可视化格式化语言
         |：父视图边缘
         H：水平方向
         V：垂直方向
         []：一个子视图(控件)
         ()：高 宽 的条件
         -：标准间距 8
         -x-：间距 x
         |-20-view1-10-view2-10-view3-20-|
         
         参数说明：
         VisualFormat：VFL表达式
         options：多个视图的对齐方式 可使用|组合
         metrics：VFL中使用的刻度参照表
         views：VFL中视图映射
         此处options表示顶部和底部都对齐，即等高

         */
        // |-距离俯视图30-view1-间隔20-view2(等宽)-间隔-view3(等宽)-距离父视图右边30-|
        var hvfl = "|-30-[v1]-20-[v2(v1)]-20-[v3(v1)]-30-|"
        // 固定顶部位置，高度50
        var vvfl = "V:|-100-[v1(50)]"
        var map = ["v1": view1, "v2": view2, "v3": view3]
        // 顶部&底部平齐
        let options = NSLayoutFormatOptions(rawValue: NSLayoutFormatOptions.alignAllTop.rawValue|NSLayoutFormatOptions.alignAllBottom.rawValue)
        var hConstraints = NSLayoutConstraint.constraints(withVisualFormat: hvfl, options: options, metrics: nil, views: map)
        var vConstraints = NSLayoutConstraint.constraints(withVisualFormat: vvfl, options: options, metrics: nil, views: map)
        
        self.view.addConstraints(hConstraints)
        self.view.addConstraints(vConstraints)
        
        
        // 设置view4屏幕居中
        let view4 = UIView()
        view4.backgroundColor = UIColor(red: 0.95, green: 0.7, blue: 0.3, alpha: 1.0)
        self.view.addSubview(view4)
        view4.translatesAutoresizingMaskIntoConstraints = false
        
        hvfl = "[v4(100)][superview]"
        vvfl = "V:[v4(60)][superview]"
        map = ["v4": view4, "superview": self.view]
        hConstraints = NSLayoutConstraint.constraints(withVisualFormat: hvfl, options: .alignAllCenterY, metrics: nil, views: map)
        vConstraints = NSLayoutConstraint.constraints(withVisualFormat: vvfl, options: .alignAllCenterX, metrics: nil, views: map)
        self.view.addConstraints(hConstraints)
        self.view.addConstraints(vConstraints)
        
    }

}
