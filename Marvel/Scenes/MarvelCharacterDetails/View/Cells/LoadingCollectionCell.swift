//
//  LoadingCollectionCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 25/09/2023.
//

import UIKit

class LoadingCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        activityIndicatorView.startAnimating()
    }
}
