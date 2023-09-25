//
//  EmptyCollectionCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 25/09/2023.
//

import UIKit

class EmptyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emptyLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func setup(text: String) {
        emptyLbl.text = text
    }
}
