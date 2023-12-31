//
//  MarvelCharacterTableCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import UIKit
import Kingfisher

class MarvelCharacterTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var thumbnailImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        thumbnailImgView.contentMode = .scaleAspectFit
        thumbnailImgView.cornerRadius = 4.0
    }
    
    func setup(title: String?, thumbnailUrl: String?) {
        thumbnailImgView.image = nil
        titleLbl.text = title
        
        thumbnailImgView.kf.indicatorType = .activity
        if let thumbnailUrl {
            thumbnailImgView.kf.setImage(with: URL(string: thumbnailUrl),
                                         options: [.transition(.fade(0.25))]
            )
        }
    }
}
