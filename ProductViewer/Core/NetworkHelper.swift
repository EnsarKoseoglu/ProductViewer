//
//  NetworkHelper.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import Foundation

struct NetworkHelper {
  static let shared = NetworkHelper()

  private init() {}

  func deserializeObject<T: Decodable>(_ value: T.Type, withJSONObject object: Data, options opt: JSONSerialization.WritingOptions = [], function: String = "") -> T? {
    do {
      if #available(iOS 13.0, *) {
        let decodedObject = try JSONDecoder().decode(T.self, from: object)
        return decodedObject
      }
      else if value is String.Type || value is Bool.Type || value is Int.Type || value is Float.Type || value is Double.Type {
        guard let jsonStr = NSString(data: object, encoding: String.Encoding.utf8.rawValue) else {
          return nil
        }
        guard let result = jsonStr.replacingOccurrences(of: "\"", with: "") as? T else {
          let catchResult = try? JSONSerialization.jsonObject(with: object, options: .allowFragments) as? T
          return catchResult
        }
        return result
      }
      else {
        let decodedObject = try JSONDecoder().decode(T.self, from: object)
        return decodedObject
      }

    } catch let DecodingError.dataCorrupted(context) {
      print(function + " : " + context.debugDescription + "error")
    } catch let DecodingError.keyNotFound(key, context) {
      print(function + " : " + "Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.valueNotFound(value, context) {
      print(function + " : " + "Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.typeMismatch(type, context) {
      print(function + " : " + "Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print(function + " : " + "error: ", error)
    }
    return nil
  }
}
