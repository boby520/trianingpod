//
//  PhotoPickCollectionView.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/5/11.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import UIKit
import SnapKit

class PhotoPickCollectionView: UIViewController {
  var photoCollectionView: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
}



extension PhotoPickCollectionView{
  func setHomeCollectionView(){
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 30 , height: 30)
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 30
    layout.minimumLineSpacing = 30
    layout.sectionHeadersPinToVisibleBounds = true
    layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    photoCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
    photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    photoCollectionView.dataSource = self
    photoCollectionView.delegate = self
    photoCollectionView.backgroundColor = UIColor.red
    view.addSubview(photoCollectionView)
    
    photoCollectionView.snp.makeConstraints{ (make) -> Void in
      make.size.equalTo(view.frame.size)
      make.center.equalTo(view)
    }
  }
}

extension PhotoPickCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
    
    cell.lable.text = "3213213"
    
    return cell
  }
}
