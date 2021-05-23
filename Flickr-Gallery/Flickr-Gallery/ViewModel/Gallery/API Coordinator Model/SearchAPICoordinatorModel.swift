//
//  SearchAPICoordinatorModel.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

struct SearchAPICoordinatorModel {
  
    let searchText: String
    let pageNumber: Int
    let perPageResultCount: Int
    
    var baseUrlString: String {
        return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2932ade8b209152a7cbb49b631c4f9b6&format=json& nojsoncallback=1&safe_search=1&text=\(searchText)&per_page=\(perPageResultCount)&page=\(pageNumber)"
    }
    
}
