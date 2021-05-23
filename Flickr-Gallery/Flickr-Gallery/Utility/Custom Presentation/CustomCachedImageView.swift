//
//  CustomCachedImageView.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 23/05/21.
//

import UIKit

class CustomCachedImageView: UIImageView {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    func loadCacheableImage(fromURL imageURL: URL, cacheId: NSString, placeHolderImage: String) {
        image = UIImage(named: placeHolderImage)
        
        guard let cachedImage = self.imageCache.object(forKey: cacheId) else {
            utilityQueue.async { [weak self] in
                guard let data = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    guard let self = self, let image = image else { return }
                    self.image = image
                    self.imageCache.setObject(image, forKey: cacheId)
                }
            }
            return
        }
        image = cachedImage
    }
    
}
