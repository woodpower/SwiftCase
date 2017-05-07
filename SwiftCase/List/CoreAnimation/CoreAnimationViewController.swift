//
//  CoreAnimationViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/5/6.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

class CoreAnimationViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var tougle1 = false
    var tougle2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSourceCodeItem("coreanimation")
        
        // 1、CABasicAnimation (位移、旋转、缩放、变形) fromValue -- toValue
        // 2、CAKeyframeAnimation 关键帧动画 [fromValue -- toValue, ...]
        // 3、CAAnimationGroup 动画组
        
        // 常用keyPath属性
        // transform.scale      比例缩放
        // transform.scale.x    宽度缩放（x轴变化）
        // transform.scale.y    高度缩放（y轴变化）
        // transform.rotation.x 绕x轴旋转
        // transform.rotation.y 绕y轴旋转
        // transform.rotation.z 绕z轴旋转（网易云音乐Cover动画）
        // cornerRadius         设置圆角
        // backgroundColor
        // bounds               大小，中心点不变
        // position             位移
        // contents             内容（更换图片）
        // opacity              透明度
        // contentsRect.size.width  横向拉伸缩放
        
        example3()
        
        example4()
        
        example5()
        
        example6()
        
    }
    
    func example1() {
        let animation: CABasicAnimation! = CABasicAnimation(keyPath: "position")
        animation.fromValue = NSValue(cgPoint: CGPoint(x: imageView.frame.midX, y: imageView.frame.midY))
        // 动画效果kCAMediaTimingFunctionEaseInEaseOut 慢速进入 -- 中间加速 -- 结尾慢速
        // kCAMediaTimingFunctionEaseIn     渐入 慢速进入 -- 结尾快速
        // kCAMediaTimingFunctionEaseOut    渐出 快速进入 -- 结尾慢速
        // kCAMediaTimingFunctionLinear     线性 匀速移动
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 1.0
        
        if !tougle1 {
            // 属性position表示位移 冲视图的中心位置向下移动
            animation.toValue = NSValue(cgPoint: CGPoint(x: imageView.frame.midX, y: 340))
        } else {
            animation.toValue = NSValue(cgPoint: CGPoint(x: imageView.frame.midX, y: 30))
        }
        
        imageView.layer.add(animation, forKey: "position")
        
        tougle1 = !tougle1
    }
    
    func example2() {
        let animation: CABasicAnimation! = CABasicAnimation(keyPath: "position")
        // kCAFillModeForwards  当动画结束后，layer保持着动画的最后状态
        // kCAFillModeBackwards 与kCAFillModeForwards相对
        // kCAFillModeBoth      动画加入后开始动画之前layer保持开始状态，动画结束后layer保持结束状态
        // kCAFillModeRemoved   动画结束后layer恢复到之前的状态
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        let resizeAnimation: CABasicAnimation! = CABasicAnimation(keyPath: "bounds.size")
        resizeAnimation.fillMode = kCAFillModeForwards
        resizeAnimation.isRemovedOnCompletion = false
        
        // 在此点击恢复到开始位置
        if !tougle2 {
            animation.toValue = NSValue(cgPoint: CGPoint(x: 160, y: 200))
            resizeAnimation.toValue = NSValue(cgSize: CGSize(width: 240, height: 60))
        } else {
            animation.fromValue = NSValue(cgPoint: CGPoint(x: 160, y: 200))
            resizeAnimation.fromValue = NSValue(cgSize: CGSize(width: 240, height: 60))
        }
        
        imageView.layer.add(animation, forKey: "position")
        imageView.layer.add(resizeAnimation, forKey: "bounds.size")
        
        tougle2 = !tougle2
    }
    
    func example3() {
        // 心脏跳动
        let imageView = UIImageView(frame: CGRect(x: 50, y: 200, width: 50, height: 50))
        imageView.image = UIImage(named: "heart.png")
        view.addSubview(imageView)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 0.5)
        animation.toValue = NSNumber(value: 1.5)
        animation.duration = 1.0
        animation.repeatCount = MAXFLOAT
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        // forKey 这个名字是可以随便取得 heart
        imageView.layer.add(animation, forKey: "heart")
    }
    
    func example4() {
        // 音乐封面无限旋转
        let imageView = UIImageView(frame: CGRect(x: view.frame.width * 0.5 - 100, y: view.frame.height * 0.5 - 100, width: 200, height: 200))
        imageView.image = UIImage(named: "image")
        imageView.layer.cornerRadius = imageView.frame.width * 0.5
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: 2 * Double.pi)
        animation.duration = 2.5
        animation.repeatCount = MAXFLOAT
        
        imageView.layer.add(animation, forKey: "transform.rotation.z")
    }
    
    func example5() {
        // 心脏收缩
        let imageView = UIImageView(frame: CGRect(x: 50, y: 300, width: 50, height: 50))
        imageView.image = UIImage(named: "heart.png")
        view.addSubview(imageView)
        
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        // values 存放动画轨迹集合
        animation.values = [0.0, 0.4, 0.8, 1.2, 1.6, 1.2, 0.8, 0.4, 0.0]
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        
        imageView.layer.add(animation, forKey: "heart")
    }
    
    func example6() {
        let view = UIView(frame: CGRect(x: 200, y: 10, width: 120, height: 120))
        self.view.addSubview(view)
        
        let duration = 1.0
        
        // 大小变化
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1.0]
        scaleAnimation.values = [1, 0.4, 1]
        scaleAnimation.duration = duration
        // 透明度
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0, 0.5, 1.0]
        opacityAnimation.values = [1, 0.3, 1.0]
        opacityAnimation.duration = duration
        // 组动画
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        groupAnimation.duration = duration
        groupAnimation.repeatCount = MAXFLOAT
        groupAnimation.isRemovedOnCompletion = false
        
        var beginTimes = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
        // 创建8个小圆并添加组动画
        for i in 0..<8 {
            let c = circle(
                angle: CGFloat(Double(i) * Double.pi * 0.25),
                size: 10,
                origin: CGPoint(x: 0, y: 0),
                containerSize: CGSize(width: 40, height: 40),
                color: UIColor.orange)
            groupAnimation.beginTime = beginTimes[i]
            c.add(groupAnimation, forKey: "loading")
            view.layer.addSublayer(c)
        }
        
    }
    
    func circle(angle: CGFloat, size: CGFloat, origin: CGPoint, containerSize: CGSize, color: UIColor) -> CALayer {
        let radius = containerSize.width * 0.5
        let circle = layer(size: CGSize(width: size, height: size), color: color)
        let frame = CGRect(
            x: origin.x + radius * (cos(angle) + 1) - size * 0.5,
            y: origin.y + radius * (sin(angle) + 1) - size * 0.5,
            width: size,
            height: size)
        circle.frame = frame
        return circle
    }
    func layer(size: CGSize, color: UIColor) -> CALayer {
        // CAShapeLayer是一个通过矢量图形而不是位图来绘制，用CGPath来定义要绘制的图形
        // Core Graphics可以直接在原始的layer中绘制图形
        // CAShapeLayer使用了GPU加速
        let layer = CAShapeLayer()
        // 根据中心点画圆
        let path = UIBezierPath(
            arcCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
            radius: size.width * 0.5,
            startAngle: 0,
            endAngle: CGFloat(2 * Double.pi),
            clockwise: false)
        // 填充颜色
        layer.fillColor = color.cgColor
        // 把贝塞尔曲线路径设为layer的渲染路径
        layer.path = path.cgPath
        return layer
    }
    
    
    @IBAction func example1(_ sender: UIButton) {
        example1()
    }
    @IBAction func example2(_ sender: UIButton) {
        example2()
    }
    

}
