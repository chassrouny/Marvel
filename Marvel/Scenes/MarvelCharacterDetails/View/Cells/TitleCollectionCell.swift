//
//  TitleCollectionCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 25/09/2023.
//

import UIKit

class TitleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLbl.numberOfLines = 2
        titleLbl.adjustsFontSizeToFitWidth = true
        bgView.cornerRadius = 10
        bgView.backgroundColor = .systemGray2
    }
    
    func setup(title: String?) {
        titleLbl.text = title
    }
}
