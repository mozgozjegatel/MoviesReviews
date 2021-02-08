//
//  BGBJSONRPCResponse.swift
//  SwiftBilling
//
//  Created by SERGEY KULABUHOV on 07.02.2021.
//

import Foundation

protocol NYTResponse: Codable {
    var status: String? {get}
    var has_more: Bool  {get}
    var num_results: Int?  {get}
    
    //var data: Codable? {get}
}
//
//protocol BGBResponseResult {
//    var data: BGBTVResultData? {get}
//}

struct NYTJSONRPCResponse<T: Codable>:  Codable{
    
    var status: String?
    var has_more: Bool
    var num_results: Int?
    var results: [T]
    
}
