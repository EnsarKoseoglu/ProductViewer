//
//  Int+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//

import Foundation

extension Optional where Wrapped == Int {
  var orEmpty: Int {
    if self == nil {
      return 0
    }
    return self!
  }
}

extension Int {
  func roundToNearestHunderedth() -> Int {
    let a = (self / 100) * 100
    let b = a + 100

    return (self - a < b - self) ? b : a
  }
}
