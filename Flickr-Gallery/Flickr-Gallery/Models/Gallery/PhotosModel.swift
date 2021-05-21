//
//  Photos.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

struct PhotosModel: Decodable {
    let photos: PhotosData?
    let stat: String
}

struct PhotosData: Decodable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
}
