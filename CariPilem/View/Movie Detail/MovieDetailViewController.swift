//
//  MovieDetailViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 19/08/21.
//

import UIKit
import Combine
import Kingfisher

class MovieDetailViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var taglineLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  private var menuDetail = ["Summary", "View Trailer", "View Rating"]
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  var movieId: Int?
  var movieDetailViewModel: MovieDetailViewModel!
  var movie: MovieDetailWelcome? {
    didSet {
      if let data = movie {
        layoutView(model: data)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
    fetchMovie()
    observeViewModel()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.scrollView.layoutIfNeeded()
  }
  
  private func setupViewModel(){
    movieDetailViewModel = MovieDetailViewModel(networking: networking, endpoint: .movieDetail)
  }
  
  private func fetchMovie(){
    if let id = movieId {
      movieDetailViewModel.fetchMovieDetail(movieId: id)
    }
  }
  
  private func observeViewModel(){
    subscriber = movieDetailViewModel.movieDetailSubject.sink(receiveCompletion: { (resultCompletion) in
      switch resultCompletion {
      case .failure(let error):
        print(error.localizedDescription)
      default: break
      }
    }, receiveValue: { (resultWelcome) in
      DispatchQueue.main.async {
        self.movie = resultWelcome
      }
    })
  }
  
  private func layoutView(model: MovieDetailWelcome){
    titleLabel.text = model.title
    taglineLabel.text = model.tagline
    overviewLabel.text = model.overview

    if let rating = model.voteAverage {
      ratingLabel.text = "\(rating)"
    }
    
    if let path = model.posterPath {
      guard let imageURL = URL(string: Constants.APIPath.BaseImageURL + path) else { return }
      posterImage.kf.setImage(with: imageURL)
    }
  }
}
