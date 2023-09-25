//
//  HeaderCollectionCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 25/09/2023.
//

import UIKit

class HeaderCollectionCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }

    func setup(title: String) {
        self.titleLabel.text = title
    }
}
