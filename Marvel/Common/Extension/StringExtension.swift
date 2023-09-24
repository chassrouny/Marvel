//
//  StringExtension.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import CryptoKit

extension String {
    //Generate MD5 Hash from a String
    func MD5() -> String {
        let digest = Insecure.MD5.hash(data: Data(self.utf8))
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
