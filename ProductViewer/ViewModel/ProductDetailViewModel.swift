//
//  ProductDetailViewModel.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import Foundation

protocol IProductDetail: AnyObject {
  var productCode: Int { get set }
  var onSuccess: (() -> Void)? { get set }
  var onFailure: ((Error?) -> Void)? { get set }

  func getProductDetail()
}

final class ProductDetailViewModel: IProductDetail {
  private let apiService: NetworkManager
  var productCode: Int

  init(apiService: NetworkManager, code: Int) {
    self.apiService = apiService
    self.productCode = code
  }

  var product: ProductDetail?
  var onSuccess: (() -> Void)?
  var onFailure: ((Error?) -> Void)?

  func getProductDetail() {
    let requestModel = NetworkModel(url: Constants.detailBaseUrl, method: .get, queryItems: ["code" : "\(self.productCode)"])
    apiService.sendRequest(requestModel) { result in
      switch result {
      case .success(let data):
        guard let product = NetworkHelper.shared.deserializeObject(ProductDetailResult.self, withJSONObject: data) else {
          self.onFailure?(NetworkError.serializationError)
          return
        }
        self.product = product.result
        self.onSuccess?()
      case .failure(let error):
        self.onFailure?(error)
      }
    }
  }
}
