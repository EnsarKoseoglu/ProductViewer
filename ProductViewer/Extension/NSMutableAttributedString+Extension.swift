//
//  NSMutableAttributedString+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 5.01.2023.
//

import UIKit

extension NSMutableAttributedString {
  var fontSize: CGFloat { return 14 }
  var boldFont: UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
  var normalFont:UIFont { return UIFont.systemFont(ofSize: fontSize)}

  func bold(_ value:String) -> NSMutableAttributedString {
    let attributes:[NSAttributedString.Key : Any] = [
      .font : boldFont
    ]

    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
  }

  func normal(_ value:String) -> NSMutableAttributedString {
    let attributes:[NSAttributedString.Key : Any] = [
      .font : normalFont,
    ]

    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
  }
}
