//
//  NYTResultData.swift
//  SwiftBilling
//
//  Created by SERGEY KULABUHOV on 07.02.2021.
//

import Foundation

//struct NYTResultData: Codable {
//
//    let results: [NYTReviev]?
//}

struct NYTResultData: Codable, Hashable, Equatable {
//    static func == (lhs: NYTResultData, rhs: NYTResultData) -> Bool {
//        return lhs.display_title == rhs.display_title && lhs.byline == rhs.byline
//    }
//    
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(byline)
//    }
    
    struct NYTLink: Codable, Hashable {
        let type: String
        let url: String
        let suggested_link_text: String
        
    }
    
    struct NYTMultimedia: Codable , Hashable{
        let type: String
        let src: String
        let height: Int
        let width: Int
    }
    
    let display_title: String
    let mpaa_rating: String
    let critics_pick: Int
    let byline: String
    let headline: String
    let summary_short: String
    let publication_date: String
    let opening_date: String?
    let date_updated: String
    let link: NYTLink
    let multimedia: NYTMultimedia
    
}
