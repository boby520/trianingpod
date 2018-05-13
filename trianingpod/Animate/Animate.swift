//
//  Animate.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/3/14.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import Foundation
import UIKit

//withDuration：动画的持续时间，也可理解为动画的执行速度，持续时间越小速度越快
//delay：动画开始之前的延时，默认是无延时。
//options：一个附加选项，UIViewAnimationOptions 可以指定多个
//options:[.repeat, .autoreverse, ]
//.Repeat：该属性可以使你的动画永远重复的运行。
//.Autoreverse：该属性可以使你的动画当运行结束后按照相反的行为继续运行回去。该属性只能和.Repeat属性组合使用。
//animations：执行动画的闭包
//completion：动画完成后执行的闭包，可以为nil，可以在这里链接下一个动画。

class Animate{
  //弹性动作
  class func  elasticitAnimate(view: UIView){
    view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 0.5, options: UIViewAnimationOptions(),animations: {
      view.transform = CGAffineTransform.identity
    }, completion: {_ in
      //动作结束都可以执行别的动作
    })
  }
  //修改颜色
  class func colorAnimate(view: UIView){
    UIView.animate(withDuration: 0.4) {
      view.backgroundColor = UIColor.red
    }
  }
  //移动
  class func transAnimate(view: UIView, y: CGFloat){
    UIView.animate(withDuration: 0.2){
      view.center.y = y
     
    }
  }
  
}
