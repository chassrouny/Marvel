//
//  EndpointProtocol.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import Alamofire

protocol EndpointProtocol {
    var baseUrl: String { get }
    var api: String { get }
    //For now we are going to use only GET method
    var httpMethod: HTTPMethod { get }
}
