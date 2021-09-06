//
//  Presenter.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 03/09/21.
//

import Foundation

protocol ReviewPresenterProtocol: AnyObject {
  var router: ReviewRouterProtocol? { get set }
  var interactor: ReviewInteractorProtocol? { get set }
  var view: ReviewViewProtocol? { get set }
  
  func interactorDidFetchData(with result: Result<ReviewWelcome, Error>)
}
