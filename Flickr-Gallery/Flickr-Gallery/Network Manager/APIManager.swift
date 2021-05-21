//
//  APIManager.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

import Foundation

struct APIManager {
    
    static func loadData(for searchModel:SearchAPICoordinatorModel, completion: @escaping (Data?, Error?) -> ()) {
        let urlString = searchModel.baseUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let url = URL(string: urlString ?? "")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let apiError = error {
                completion(nil, apiError)
            }
            else if let response = data {
                completion(response, nil)
            }
        }.resume()
    }
    
}
