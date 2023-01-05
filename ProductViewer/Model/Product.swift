//
//  Product.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 2.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import Foundation

// MARK: - GetProductResult
struct GetProductResult: Codable {
  let result: ProductResult
}

// MARK: - Result
struct ProductResult: Codable {
  let nextUrl: String?
  let horizontalProducts: [Product]?
  let products: [Product]
}

// MARK: - Product
struct Product: Codable {
  let code: Int?
  let imageUrl: String?
  let name: String?
  let dropRatio: Double?
  let price: Double?
  let countOfPrices: Int?
  let followCount: Int?
}
