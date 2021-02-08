//
//  NYTManager.swift
//  SwiftBilling
//
//  Created by SERGEY KULABUHOV on 07.02.2021.
//

import Foundation

//
//  BGBTVManager.swift
//  MoviesReviews
//
//  Created by SERGEY KULABUHOV on 06.02.2021.
//

import Foundation


protocol NYTManagerDelegate {
    func dataEndloading(_ result: NYTJSONRPCResponse<NYTResultData>)
}


struct NYTManager {
    
    var delegate: NYTManagerDelegate?
    
    let host = "api.nytimes.com"
    let port = 80
    let proto = "http"
    let apiKey = ""
    let apiNYT = NYTAPIType.JSONRPC

    var url: String {
        
        
        let finalURL = "\(proto)://\(host):\(port)/\(apiNYT.name)/search.json?api-key=\(apiKey)"
        
        print("Test :" + finalURL + ": ok")
        return finalURL
    }
    
    mutating func fetchReviews() {
        
        performRequest(urlString: url)
        print("fetch ok")
        
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
                        
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession(configuration: .default)
            //URLSessionConfiguration.default.tlsMaximumSupportedProtocol = SSLProtocol.tlsProtocol1
            session.configuration.tlsMinimumSupportedProtocol = SSLProtocol.tlsProtocol1
                let task = session.dataTask(with: request, completionHandler: hendle)

            task.resume()
            
        } else {
            print("Error, no data returned!")
        }
    }
    
    func hendle(data: Data?, response: URLResponse?, error: Error?) {
        
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            if let response: NYTJSONRPCResponse<NYTResultData> = parceJSON(reviewsData: safeData) {
                delegate?.dataEndloading(response)
                //                      for review in reviews.results {
                //                          print("\(review.byline)")
                            //}
                //print(response)
                print(String(data: safeData, encoding: .utf8)!)
            }

        }
    }
    
    func parceJSON<T: Decodable>(reviewsData: Data) ->T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: reviewsData)
            
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}





