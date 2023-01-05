//
//  ProductDetail.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 4.01.2023.
//

import Foundation

struct ProductDetailResult: Codable {
  let result: ProductDetail?
}

struct ProductDetail: Codable {
  let mkName: String?
  let productName: String?
  let badge: String?
  let rating: Double?
  let imageUrl: String?
  let storageOptions: [String]?
  let countOfPrices: Int?
  let price: Double?
  let freeShipping: Bool?
  let lastUpdate: String?
}
