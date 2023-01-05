//
//  String+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//

import Foundation

extension Optional where Wrapped == String {
  var orEmpty: String {
    if self == nil {
      return ""
    }
    return self!
  }
}

