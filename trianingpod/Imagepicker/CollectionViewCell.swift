//
//  ImageCollectionViewCell.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/3/15.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(imageView)
    
    imageView.snp.makeConstraints{ (make) -> Void in
      make.centerX.equalTo(self)
      make.size.equalTo(self.frame.size)
    }
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CollectionViewCell{
  
}
