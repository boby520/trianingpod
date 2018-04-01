//
//  Common+Extensions.swift
//  trianingpod
//
//  Created by 林洪州 on 2018/4/1.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import Foundation

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
  #if DEBUG
    guard let object = object else { return }
    print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
  #endif
}

