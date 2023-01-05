//
//  NetworkManager.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 2.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import Foundation

protocol IService: AnyObject {
  func sendRequest<T:IRequest>(_ components: T, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager: IService {
  private func createNewSession() -> URLSession {
    return URLSession.shared
  }

  private func createNewRequest(_ request: IRequest) -> URLRequest? {
    guard var urlComponent = URLComponents(string: request.url) else {
      return nil
    }

    var queryItems: [URLQueryItem] = []

    request.queryItems.forEach {
      let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
      urlComponent.queryItems?.append(urlQueryItem)
      queryItems.append(urlQueryItem)
    }

    guard let url = urlComponent.url else {
      return nil
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue

    return urlRequest
  }

  func sendRequest<T>(_ components: T, completion: @escaping (Result<Data, Error>) -> Void) where T : IRequest {
    let session = createNewSession()
    guard let request = createNewRequest(components) else {
      completion(.failure(NetworkError.invalidEndpoint))
      return
    }

    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
      guard error == nil else {
        completion(.failure(error ?? NetworkError.failed))
        return
      }

      guard let responseData = data,
            let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(HttpError.invalidResponse(data, NetworkError.apiError)))
        return
      }

      switch httpResponse.statusCode {
      case 200...299:
        return completion(.success(responseData))
      case 401...500:
        return completion(.failure(NetworkError.authenticationError))
      case 501...599:
        return completion(.failure(NetworkError.badRequest))
      case 600:
        return completion(.failure(NetworkError.outdated))
      default:
        return completion(.failure(NetworkError.failed))
      }
    }
    task.resume()
  }
}

enum HttpError: Error {
  case invalidURL
  case invalidResponse(Data?, NetworkError)
}

enum HttpMethod: String {
  case post = "POST"
  case get = "GET"
  case put = "PUT"
  case delete = "DELETE"
}

enum NetworkError: Error {
  case invalidEndpoint
  case authenticationError
  case badRequest
  case failed
  case noData
  case apiError
  case outdated
  case serializationError
}
