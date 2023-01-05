//
//  CellInterface.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import UIKit

protocol CellInterface {
  static var id: String { get }
  static var cellNib: UINib { get }
}

extension CellInterface {

  static var id: String {
    return String(describing: Self.self)
  }

  static var cellNib: UINib {
    return UINib(nibName: id, bundle: nil)
  }
}
