//
//  NYTAPIType.swift
//  SwiftBilling
//
//  Created by SERGEY KULABUHOV on 07.02.2021.
//

import Foundation

enum NYTAPIType: String {
    case JSONRPC = "svc/movies/v2/reviews"
    var name: String {
        rawValue
    }
}
