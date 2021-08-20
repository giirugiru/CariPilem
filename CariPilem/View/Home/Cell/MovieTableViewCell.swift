//
//  MovieTableViewCell.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 19/08/21.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
  
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  static let cellIdentifier = String(describing: MovieTableViewCell.self)
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  static func nib() -> UINib {
    return UINib(nibName: cellIdentifier, bundle: nil)
  }
  
  public func configure(with model: MovieList){
    titleLabel.text = model.title
    releaseDateLabel.text = model.releaseDate
    
    if let rating = model.voteAverage {
      ratingLabel.text = "\(rating)/10"
    }
    
    if let path = model.posterPath {
      guard let imageURL = URL(string: Constants.APIPath.BaseImageURL + path) else { return }
      posterImage.kf.setImage(with: imageURL)
    }
    
  }
  
}
