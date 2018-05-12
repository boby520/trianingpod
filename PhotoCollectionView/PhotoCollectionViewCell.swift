//
//  CollectionViewCell.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/5/10.
//  Copyright © 2018年 林洪州. All rights reserved.
//


import UIKit
import SnapKit


class PhotoCollectionViewCell: UICollectionViewCell {
  
  var isOpen: Bool = false
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.layer.borderWidth = 0.3
    imageView.backgroundColor = UIColor.white
    return imageView
  }()

  
  lazy var imageView2: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.layer.borderWidth = 0.3
    imageView.backgroundColor = UIColor.white
    return imageView
  }()
  
  lazy var lable: UILabel = {
    let lable = UILabel()
    lable.translatesAutoresizingMaskIntoConstraints = false
    lable.text = "000"
    lable.textColor = UIColor.blue
    
    return lable
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()

    
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension PhotoCollectionViewCell{
  func setUI(){
//    addSubview(imageView)
//    addSubview(imageView2)
    addSubview(lable)
//
//    imageView.snp.makeConstraints{ (make) -> Void in
//      make.center.equalTo(self)
//      make.size.equalTo(CGSize(width: 200, height: 200))
//    }
//
//    imageView2.snp.makeConstraints{ (make) -> Void in
//      make.center.equalTo(self)
//      make.size.equalTo(CGSize(width: 200, height: 200))
//    }
//
    lable.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.centerX.equalTo(self)
    }
  }
}

//MAKR:- selectionView
extension PhotoCollectionViewCell{
 
}
