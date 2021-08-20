//
//  MovieReviewViewModel.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 20/08/21.
//

import Foundation
import Combine

// https://api.themoviedb.org/3/movie/385128/reviews?api_key=e7d22d38c7ac25f61485e43850ee10e8&language=en-US&page=1

class MovieReviewViewModel {
  
  private let networking: NetworkProtocol
  private let endpoint: Constants.Endpoint
  
  var movieReviewSubject = PassthroughSubject<ReviewWelcome, Error>()
  
  init(networking: NetworkProtocol, endpoint: Constants.Endpoint) {
    self.networking = networking
    self.endpoint = endpoint
  }
  
  func fetchMovieReview(page: Int, movieId: Int) {
    let url = endpoint.urlString
    let finalUrl = url.replacingOccurrences(of: "$$$", with: "\(movieId)")
    let param = [
      Constants.APIKey.Key: Constants.APIKey.Value,
      Constants.Language.Key: Constants.Language.Value,
      Constants.Page.Key: "\(page)"
    ]
    
    networking.fetchItems(url: finalUrl, parameters: param) { [weak self] (result: Result<ReviewWelcome, Error>) in
      switch result {
      case .success(let resultWelcome):
        self?.movieReviewSubject.send(resultWelcome)
      case .failure(let error):
        self?.movieReviewSubject.send(completion: .failure(error))
      }
    }
  }
  
}
