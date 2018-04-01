//
//  Consume.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/3/5.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import Foundation
import RealmSwift

class ConsumeType:Object {
  //类型名
  @objc dynamic var name = ""
}

//消费条目
class ConsumeItem: Object {
  
  @objc dynamic var a = ""
  
  @objc dynamic var abc = ""
  //条目名
  @objc dynamic var name = ""
  //金额
  @objc dynamic var cost = 0.00
  //时间
  @objc dynamic var date = Date()
  
  //所属消费类别
  @objc dynamic var type: ConsumeType?
  
}
