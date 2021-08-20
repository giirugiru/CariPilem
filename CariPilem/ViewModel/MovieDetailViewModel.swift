//
//  MovieDetailViewModel.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 20/08/21.
//

import Foundation
import Combine

// https://api.themoviedb.org/3/movie/385128?api_key=e7d22d38c7ac25f61485e43850ee10e8&language=en-US

class MovieDetailViewModel {
  
  private let networking: NetworkProtocol
  private let endpoint: Constants.Endpoint
  
  var movieDetailSubject = PassthroughSubject<MovieDetailWelcome, Error>()
  
  init(networking: NetworkProtocol, endpoint: Constants.Endpoint) {
    self.networking = networking
    self.endpoint = endpoint
  }
  
  func fetchMovieDetail(movieId: Int) {
    let url = endpoint.urlString + "/\(movieId)"
    let param = [
      Constants.APIKey.Key: Constants.APIKey.Value,
      Constants.Language.Key: Constants.Language.Value,
    ]
    
    networking.fetchItems(url: url, parameters: param) { [weak self] (result: Result<MovieDetailWelcome, Error>) in
      switch result {
      case .success(let resultWelcome):
        self?.movieDetailSubject.send(resultWelcome)
      case .failure(let error):
        self?.movieDetailSubject.send(completion: .failure(error))
      }
    }
  }
  
}
