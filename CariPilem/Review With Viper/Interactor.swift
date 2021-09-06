//
//  Interactor.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 03/09/21.
//

import Foundation

protocol ReviewInteractorProtocol {
  var presenter: ReviewPresenterProtocol? { get set }
  func getReviews(id: Int, page: Int)
}

class ReviewInteractor: ReviewInteractorProtocol {
  
  var presenter: ReviewPresenterProtocol?
  
  func getReviews(id: Int, page: Int) {
    let urlString = Constants.Endpoint.movieReview.urlString
    let finalUrl = urlString.replacingOccurrences(of: "$$$", with: "\(id)")
    guard let url = URL(string: finalUrl) else { return }
    let param = [
      Constants.APIKey.Key: Constants.APIKey.Value,
      Constants.Language.Key: Constants.Language.Value,
      Constants.Page.Key: "\(page)"
    ]
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let data = data, error == nil else {
        self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
        return
      }
      do {
        let model = try JSONDecoder().decode([User].self, from: data)
        self?.presenter?.interactorDidFetchUsers(with: .success(model))
      } catch {
        self?.presenter?.interactorDidFetchUsers(with: .failure(error))
      }
    }
    task.resume()
  }
  
}
