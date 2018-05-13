//
//  CellView.swift
//  testApplicationCalendar
//
//  Created by JayT on 2016-03-04.
//  Copyright © 2016 OS-Tech. All rights reserved.
//


import JTAppleCalendar
import SnapKit

class CellView: JTAppleCell {
  
  lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 2
    
    return label
  }()
  
  lazy var selectedView: UIView = {
    let selectedView = UIView()
    selectedView.translatesAutoresizingMaskIntoConstraints = false
    selectedView.backgroundColor = UIColor.gray
    selectedView.layer.cornerRadius = 10
    selectedView.layer.masksToBounds = false
    
    return selectedView
  }()
  
  lazy var dotMakerView: UIView = {
    let dotMakerView = UIView()
    dotMakerView.translatesAutoresizingMaskIntoConstraints = false
    dotMakerView.backgroundColor = UIColor.clear
    
    return dotMakerView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension CellView{
  func setUI(){
   
    addSubview(selectedView)
    addSubview(dayLabel)
    addSubview(dotMakerView)
    
    dayLabel.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self)
    }
    
    selectedView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: 30, height: 30))
      make.center.equalTo(dayLabel)
    }
    
    dotMakerView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(selectedView.snp.bottom)
      make.centerX.equalTo(selectedView)
      make.size.equalTo(CGSize(width: 27, height: 4))
    }
  }
}

extension CellView{
  func addMakers(colors: [UIColor], bool:Bool){
    if(bool){
      for (index, color) in colors.enumerated(){
        let doMarkers = UIView()
        let leftCGFlot:CGFloat = CGFloat(27/colors.count*index+21/colors.count/2)
        doMarkers.backgroundColor = color
        doMarkers.layer.cornerRadius = 2
        doMarkers.layer.masksToBounds = false
        
        dotMakerView.addSubview(doMarkers)
        doMarkers.snp.makeConstraints { (make) -> Void in
          make.left.equalTo(dotMakerView).offset(leftCGFlot)
          make.centerY.equalTo(dotMakerView)
          make.size.equalTo(CGSize(width: 4, height: 4))
        }
      }
    }
  }
  
  
  
}
