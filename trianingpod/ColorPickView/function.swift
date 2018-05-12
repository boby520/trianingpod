//
//  function.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/5/10.
//  Copyright © 2018年 林洪州. All rights reserved.
//

//import Foundation
//
//
//class Pickerfunc {
//    //颜色选择器
//  class func setColorPick(){
//    let alert = UIAlertController(style: .actionSheet)
//    alert.addColorPicker(color: UIColor(hex: 0xFF2DC6), title: "Selcet color") { color in Log(color)
//      print("选择的颜色是颜色\(color.hexString)")
//      
//    }
//    alert.addAction(title: "Cancel", style: .cancel){ _ in
//      
//    }
//    alert.show()
//  }
//  
//   //数字选择pickview
//    class  func setPickView(){
//    let alert = UIAlertController(style: .alert, title: "Picker View", message: "Preferred Content Height")
//    let frameSizes: [CGFloat] = (8...23).map { CGFloat($0) }
//    let pickerViewValues: [[String]] = [frameSizes.map { Int($0).description }]
//    let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.index(of: 3) ?? 0)
//    
//    alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
//      var i = Int(frameSizes[index.row])
//      print("选择的数字是\(i)")
//      
//    }
//    alert.addAction(title: "Done", style: .cancel)
//    alert.show()
//  }
//}
