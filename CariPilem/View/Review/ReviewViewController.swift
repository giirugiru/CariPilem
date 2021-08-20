//
//  ReviewViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 20/08/21.
//

import UIKit
import Combine

class ReviewViewController: UIViewController {
  
  @IBOutlet weak var reviewTableView: UITableView!
  
  var reviews: [ReviewResult] = []
  var movieReviewViewModel: MovieReviewViewModel!
  var page = 1
  var maxPage: Int?
  var movieId: Int?
  
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTable()
    setupViewModel()
    fetchReviews()
    observeViewModel()
  }
  
  private func setupTable(){
    reviewTableView.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.cellIdentifier)
    reviewTableView.dataSource = self
    reviewTableView.delegate = self
    reviewTableView.bounces = false
  }
  
  private func setupViewModel(){
    movieReviewViewModel = MovieReviewViewModel(networking: networking, endpoint: .movieReview)
  }
  
  private func fetchReviews(){
    if let id = movieId {
      movieReviewViewModel.fetchMovieReview(page: page, movieId: id)
    }
  }
  
  private func observeViewModel(){
    subscriber = movieReviewViewModel.movieReviewSubject.sink(receiveCompletion: { (resultCompletion) in
      switch resultCompletion {
      case .failure(let error):
        print(error.localizedDescription)
      default: break
      }
    }, receiveValue: { (resultWelcome) in
      DispatchQueue.main.async {
        self.maxPage = resultWelcome.totalPages
        if let result = resultWelcome.results {
          self.reviews = result
        }
        self.reviewTableView.reloadData()
      }
    })
  }
  
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
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
      page += 1
      if let id = movieId, let max = maxPage {
        if page < max {
          movieReviewViewModel.fetchMovieReview(page: page, movieId: id)
          observeViewModel()
        }
      }
    }
  }
}
