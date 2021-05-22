//
//  ImageUrlFactory.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

struct ImageUrlFactory {
    
    let photoModel: Photo
    
    func getUrl() -> String? {
        guard let farm = photoModel.farm,
              let server = photoModel.server,
              let id = photoModel.id,
              let secret = photoModel.secret else { return nil }
        
        let urlString = "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        return urlString
    }
    
}
