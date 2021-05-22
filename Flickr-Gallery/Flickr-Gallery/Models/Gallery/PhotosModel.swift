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
    let currentPage: Int
    let totalPages: Int
    let currentPageItems: Int
    let total: Int
    let allPhotos: [Photo]
    
    private enum CodingKeys : String, CodingKey {
        case currentPage = "page"
        case totalPages = "pages"
        case currentPageItems = "perpage"
        case total = "total"
        case allPhotos = "photo"
    }
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
