//
//  Double+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//

import UIKit

extension Optional where Wrapped == Double {
  var orEmpty: Double {
    if self == nil {
      return 0.0
    }
    return self!
  }
}

extension Double {
  func formatPriceValue() -> String {
    let price = self as NSNumber

    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "tr_TR")
    return formatter.string(from: price).orEmpty
  }

  func formatCurrencyValue() -> NSAttributedString {
    let decimalValue = "\(self)".split(separator: ".").last
    let string = "\(Int(self)),\(decimalValue ?? "00") TL" as NSString
    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)])
    let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0)]
    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\(Int(self))"))

    return attributedString
  }
}
