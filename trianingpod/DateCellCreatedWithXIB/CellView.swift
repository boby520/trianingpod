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
    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 2
    
    return label
  }()
  
  lazy var selectedView: UIView = {
    let selectedView = UIView()
    selectedView.translatesAutoresizingMaskIntoConstraints = false
    selectedView.backgroundColor = UIColor.black
    selectedView.cornerRadius = 15
    
    return selectedView
  }()
  
  lazy var monthLabel: UILabel = {
    let monthLabel = UILabel()
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.textColor = UIColor.black
    monthLabel.font = UIFont.systemFont(ofSize: 14)
    
    return monthLabel
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
    addSubview(monthLabel)
    
    dayLabel.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self)
    }
    
    selectedView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: 30, height: 30))
      make.center.equalTo(dayLabel)
    }
    
    monthLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(dayLabel.snp.bottom).offset(-15)
    }
  }
}
