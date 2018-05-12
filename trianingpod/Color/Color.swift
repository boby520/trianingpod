//
//  Color.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/3/13.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import UIKit
import Hue

class Color{
  
  class func bg(view: UIView){
    let starColor = UIColor.red
    //蓝色
    let endColor = UIColor.white
    //将颜色和颜色的位置定义在数组内
    let gradientColors: [CGColor] = [starColor.cgColor, endColor.cgColor]
    //创建并实例化CAGradientLayer
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.colors = gradientColors
    //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
    //渲染的起始位置
    gradientLayer.startPoint = CGPoint(x:0, y:0)
    //渲染的终止位置
    gradientLayer.endPoint = CGPoint(x:0, y:0.5)
    //设置frame和插入view的layer
    gradientLayer.frame = view.bounds
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  class func cellColors() -> [UIColor]{
    let colors:[UIColor] = [UIColor(hex: "#E3F2FD"),UIColor(hex: "#BBDEFB"),UIColor(hex: "#90CAF9"),UIColor(hex: "#64B5F6"),UIColor(hex: "#42A5F5"),UIColor(hex: "#2196F3"),UIColor(hex: "#1E88E5"), UIColor(hex: "#1976D2"), UIColor(hex: "#1565C0"), UIColor(hex: "0D47A1")]
    
    return colors
  }
}
