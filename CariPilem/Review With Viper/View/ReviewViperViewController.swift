//
//  ReviewViperViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 06/09/21.
//

import UIKit

protocol ReviewViewProtocol {
  var presenter: ReviewPresenterProtocol? { get set }
  func update(with model: ReviewWelcome)
  func update(with error: Error)
}

class ReviewViperViewController: UIViewController, ReviewViewProtocol {
  
  var presenter: ReviewPresenterProtocol?
  
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.cellIdentifier)
    return table
  }()
  
  var reviews: [ReviewResult] = []
  var page = 1
  var maxPage: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func update(with model: ReviewWelcome) {
    DispatchQueue.main.async {
      self.maxPage = model.totalPages
      if let results  = model.results {
        self.reviews = results
        self.tableView.reloadData()
      }
    }
  }
  
  func update(with error: Error) {
    DispatchQueue.main.async {
      print(error.localizedDescription)
    }
  }
  
}

extension ReviewViperViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviews.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier, for: indexPath) as! ReviewTableViewCell
    let model = reviews[indexPath.row]
    cell.configure(with: model)
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == reviews.count-1 {
//      page += 1
//      if let id = movieId, let max = maxPage {
//        if page < max {
//          movieReviewViewModel.fetchMovieReview(page: page, movieId: id)
//          observeViewModel()
//        }
//      }
    }
  }
  
}
