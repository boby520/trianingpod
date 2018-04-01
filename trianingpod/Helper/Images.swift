//
//  Images.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/3/14.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import Foundation
import UIKit
import Photos

class Images {
  //压缩图片尺寸
  class func resizeImage(originalImg: UIImage) -> UIImage{
    //prepare constants
    let width = originalImg.size.width
    let height = originalImg.size.height
    let scale = width/height
    var sizeChange = CGSize()
    if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
      return originalImg
    }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
      if scale <= 2 && scale >= 1 {
        let changedWidth: CGFloat = 1280
        let changedheight: CGFloat = changedWidth / scale
        sizeChange = CGSize(width: changedWidth, height: changedheight)
      }else if scale >= 0.5 && scale <= 1 {
        let changedheight:CGFloat = 1280
        let changedWidth:CGFloat = changedheight * scale
        sizeChange = CGSize(width: changedWidth, height: changedheight)
      }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
        if scale > 2 {//高的值比较小
          let changedheight:CGFloat = 1280
          let changedWidth:CGFloat = changedheight * scale
          sizeChange = CGSize(width: changedWidth, height: changedheight)
        }else if scale < 0.5{//宽的值比较小
          let changedWidth:CGFloat = 1280
          let changedheight:CGFloat = changedWidth / scale
          sizeChange = CGSize(width: changedWidth, height: changedheight)
        }
      }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
        return originalImg
      }
    }
    UIGraphicsBeginImageContext(sizeChange)
    //draw resized image on Context
    originalImg.draw(in: CGRect(x:0, y:0, width: sizeChange.width, height: sizeChange.height))
    //create UIImage
    let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImg!
  }
  //截屏uiview
  func getImage(size: CGSize , currentView: UIView) -> UIImage {
    UIGraphicsBeginImageContextWithOptions( size, false, 0.0)
    currentView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  //截屏手机
  func screenSnapshot() -> UIImage? {
    guard let window = UIApplication.shared.keyWindow else { return nil }
    // 用下面这行而不是UIGraphicsBeginImageContext()，因为前者支持Retina
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
    window.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
  
}



