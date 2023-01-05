//
//  Bool+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 5.01.2023.
//

import Foundation

extension Optional where Wrapped == Bool {
  var orEmpty: Bool {
    if self == nil {
      return false
    }
    return self!
  }
}
