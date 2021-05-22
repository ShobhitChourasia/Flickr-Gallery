//
//  GalleryViewModel.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

import Foundation

protocol GalleryModelInput {
    var photosModel: PhotosModel? { get }
    func getData(text: String, completion: @escaping (PhotosModel?) -> ())
}

protocol GalleryModelOutput { }

protocol GalleryViewModelProtocol: GalleryModelInput, GalleryModelOutput { }

class GalleryViewModel: GalleryViewModelProtocol {
    
    var photosModel: PhotosModel?
    
    func getData(text: String, completion: @escaping (PhotosModel?) -> ()) {
        let searchAPIModel = SearchAPICoordinatorModel()
        APIManager.loadData(for: searchAPIModel) { [weak self] (response, error) in
            guard let self = self else { return }
            do {
                if let responseData = response {
                    let jsonDecoder = JSONDecoder()
                    self.photosModel = try jsonDecoder.decode(PhotosModel.self, from: responseData)
                    print(self.photosModel)
                    completion(self.photosModel)
                }
            } catch {
                completion(nil)
            }
        }
    }

}
