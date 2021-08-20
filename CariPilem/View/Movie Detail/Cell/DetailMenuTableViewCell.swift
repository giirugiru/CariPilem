//
//  DetailMenuTableViewCell.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 20/08/21.
//

import UIKit

class DetailMenuTableViewCell: UITableViewCell {
  
  @IBOutlet weak var menuTitleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  static let cellIdentifier = String(describing: DetailMenuTableViewCell.self)
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  static func nib() -> UINib {
    return UINib(nibName: cellIdentifier, bundle: nil)
  }
  
  public func configure(with model: MovieDetailWelcome){
    subtitleLabel.text = model.overview
  }
  
}
