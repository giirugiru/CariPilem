//
//  Router.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 03/09/21.
//

import Foundation
import UIKit

protocol ReviewRouterProtocol {
  // Presenter -> Router
  func pushToReviewVC(with model: ReviewWelcome, from view: UIViewController)
}

class ReviewRouter: ReviewRouterProtocol {
  func pushToReviewVC(with model: ReviewWelcome, from view: UIViewController) {
    <#code#>
  }
  
}
