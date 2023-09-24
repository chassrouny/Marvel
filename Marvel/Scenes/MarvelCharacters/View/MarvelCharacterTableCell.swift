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
        
        titleLbl.textColor = .black
        titleLbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        thumbnailImgView.contentMode = .scaleAspectFit
    }
    
    func setup(title: String?, thumbnailUrl: String?) {
        thumbnailImgView.image = nil
        titleLbl.text = title
        
        thumbnailImgView.kf.indicatorType = .activity
        if let thumbnailUrl {
            thumbnailImgView.kf.setImage(with: URL(string: thumbnailUrl),
                                         options: [.transition(.fade(0.25)),
                                                   .processor(DownsamplingImageProcessor(size: CGSize(width: 150, height: 150)))]
            )
        }
    }
}
