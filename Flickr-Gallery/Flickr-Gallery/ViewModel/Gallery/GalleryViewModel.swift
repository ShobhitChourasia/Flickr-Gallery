//
//  GalleryViewModel.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

import Foundation

protocol GalleryModelInput {
    var allPhotos: [Photo] { get set }
    var currentPageNumber: Int { get set }
    var searchText: String { get set }
    var isFetchingMoreData: Bool { get set }
    
    func getImages(completion: @escaping (PhotosModel?) -> ())
    func resetPageNumber()
}

protocol GalleryModelOutput { }

protocol GalleryViewModelProtocol: GalleryModelInput, GalleryModelOutput { }

class GalleryViewModel: GalleryViewModelProtocol {
    
    var allPhotos: [Photo] = []
    var isFetchingMoreData: Bool = false
    var currentPageNumber: Int = 1
    var searchText: String = ""
    
    private var photosModel: PhotosModel?
    
    func getImages(completion: @escaping (PhotosModel?) -> ()) {
        let searchAPIModel = SearchAPICoordinatorModel(searchText: searchText,
                                                       pageNumber: currentPageNumber)
        APIManager.loadData(for: searchAPIModel) { [weak self] (response, error) in
            guard let self = self else { return }
            do {
                if let responseData = response {
                    let jsonDecoder = JSONDecoder()
                    self.photosModel = try jsonDecoder.decode(PhotosModel.self, from: responseData)
                    guard let photos = self.photosModel?.photos?.allPhotos else { return completion(nil) }
                    self.allPhotos += photos
                    completion(self.photosModel)
                }
            } catch {
                completion(nil)
            }
        }
    }
    
    func resetPageNumber() {
        currentPageNumber = 1
        allPhotos = []
    }

}
