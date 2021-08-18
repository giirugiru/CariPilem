//
//  Networking.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import Foundation
import Combine

class Networking: NetworkProtocol {
  
  private var subscribers = Set<AnyCancellable>()
    
  func fetchItems<T: Decodable>(url: String, parameters: [String: String]?, completion: @escaping (Result<T, Error>) -> Void) {
    
    let urlParameters = parameters?.queryString ?? ""
    guard let finalURL = URL(string: url + urlParameters) else { return }
    
    URLSession.shared.dataTaskPublisher(for: finalURL)
      .map{ $0.data }
      .decode(type: T.self, decoder: JSONDecoder())
      .sink(receiveCompletion: { (resultCompletion) in
        switch resultCompletion {
        case .failure(let error):
          completion(.failure(error))
        case .finished: break
        }
      }, receiveValue: { (resultArray) in
        completion(.success(resultArray))
      }).store(in: &subscribers)
  }
}

protocol NetworkProtocol {
  func fetchItems<T: Decodable>(url: String, parameters: [String: String]?, completion: @escaping (Result<T, Error>) -> Void)
}

extension Dictionary {
    var queryString: String {
        var output: String = "?"
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
