//
//  ProductListViewModel.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import Foundation

protocol IProductList: AnyObject {
  var horizontalProducts: [Product] { get set }
  var verticalProducts: [Product] { get set }
  var onSuccess: (() -> Void)? { get set }
  var onFailure: ((Error?) -> Void)? { get set }

  func getProducts(_ isPageRefreshing: Bool)
}

final class ProductListViewModel: IProductList {
  private let apiService: NetworkManager
  var pageId: String = "59906f35-d5d5-40f7-8d44-53fd26eb3a05"

  init(apiService: NetworkManager) {
    self.apiService = apiService
  }

  var horizontalProducts: [Product] = []
  var verticalProducts: [Product] = []

  var onSuccess: (() -> Void)?
  var onFailure: ((Error?) -> Void)?

  func getProducts(_ isPageRefreshing: Bool = false) {
    let requestModel = NetworkModel(url: "\(Constants.baseUrl)\(pageId)", method: .get)
    apiService.sendRequest(requestModel) { result in
      switch result {
      case .success(let data):
        guard let productResult = NetworkHelper.shared.deserializeObject(GetProductResult.self, withJSONObject: data) else {
          self.onFailure?(NetworkError.serializationError)
          return
        }
        if !isPageRefreshing {
          self.horizontalProducts = productResult.result.horizontalProducts ?? []
        }
        self.verticalProducts.append(contentsOf: productResult.result.products)
        self.pageId = productResult.result.nextUrl.orEmpty.replacingOccurrences(of: Constants.baseUrl, with: "")
        self.onSuccess?()
      case .failure(let error):
        self.onFailure?(error)
      }
    }
  }
}
