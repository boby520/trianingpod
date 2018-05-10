//
//  gameViewController.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/5/8.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    
    self.view.backgroundColor = UIColor.white
    
    let buttom = UIButton()
    buttom.translatesAutoresizingMaskIntoConstraints = false
    buttom.backgroundColor = UIColor.black
    buttom.addTarget(self, action: #selector(hanlder), for: .touchUpInside)
    view.addSubview(buttom)
    buttom.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width:50,height:50))
      make.center.equalTo(view)
    }

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension GameViewController{
  @objc func hanlder(){
    self.dismiss(animated: true, completion: nil)
  }
}
