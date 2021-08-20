//
//  ReviewTableViewCell.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 20/08/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
  
  @IBOutlet weak var authorImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var reviewTextView: UITextView!
  
  static let cellIdentifier = String(describing: ReviewTableViewCell.self)
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  static func nib() -> UINib {
    return UINib(nibName: cellIdentifier, bundle: nil)
  }
  
  public func configure(with model: ReviewResult){
    
    nameLabel.text = model.author
    reviewTextView.text = model.content
    
    if let rating = model.authorDetails?.rating {
      switch rating {
      case ...5.0:
        ratingLabel.textColor = .red
      case 5.1...7.0:
        ratingLabel.textColor = .orange
      case 7.0...8.0:
        ratingLabel.textColor = .yellow
      default:
        ratingLabel.textColor = .green
      }
      ratingLabel.text = "\(rating)/10"
    } else {
      ratingLabel.isHidden = true
    }
    
    if let path = model.authorDetails?.avatarPath {
      guard let imageURL = URL(string: Constants.APIPath.BaseImageURL + path) else { return }
      authorImage.kf.setImage(with: imageURL)
    }
    
  }
  
}
