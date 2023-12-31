//
//  BaseViewController.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    deinit {
        print("DEINIT: \(String(describing: self))")
    }
    
    func setupInterface() {}
}
