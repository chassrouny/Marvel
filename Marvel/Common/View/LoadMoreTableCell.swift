//
//  LoadMoreTableCell.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import UIKit

class LoadMoreTableCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
}
