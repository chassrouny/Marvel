//
//  ComicCollectionCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import UIKit
import Kingfisher
import SkeletonView

class ImageTitleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.cornerRadius = 6
        contentView.clipsToBounds = true
        titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLbl.numberOfLines = 0
    }
    
    func setup(title: String?, imageUrl: String?) {
        titleLbl.text = title
        imgView.image = nil
        self.showAnimatedGradientSkeleton()
        if let url = imageUrl {
            imgView.kf.setImage(with: URL(string: url),
                                options: [.transition(.fade(0.25))]) { [weak self] result in
                self?.hideSkeleton()
            }
        }
    }
}
