//
//  MarvelCharacterDetailsRouter.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import UIKit

class MarvelCharacterDetailsRouter {
    static let storyBoard = UIStoryboard(name: "MarvelCharacterDetails", bundle: .main)
    
    class func characterDetailsVC(character: MarvelCharacter) -> MarvelCharacterDetailsViewController {
        let vc = storyBoard.instantiateViewController(withIdentifier: "MarvelCharacterDetailsViewController") as! MarvelCharacterDetailsViewController
        vc.character = character
        return vc
    }
}
