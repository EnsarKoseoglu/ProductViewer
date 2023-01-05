//
//  NetworkModel.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 2.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import Foundation

protocol IRequest {
  var url: String { get }
  var method: HttpMethod { get }
  var queryItems: [String : String] { get }
}

struct NetworkModel: IRequest {
  var url: String
  var method: HttpMethod
  var queryItems: [String:String]

  init(url: String, method: HttpMethod, queryItems: [String:String] = [:]) {
    self.url = url
    self.method = method
    self.queryItems = queryItems
  }
}
