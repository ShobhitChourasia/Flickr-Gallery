//
//  GalleryViewController.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

import UIKit

class GalleryViewController: CustomViewController<GalleryView> {

    var viewModel: GalleryViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GalleryViewModel()
        setupNavBar()
        setupCollectionView()
        
        viewModel.getData(text: "") { [weak self] (response) in
            guard let self = self,
                  let _ = response else { return }
            
            DispatchQueue.main.async {
                self.customView.collectionView.isHidden = false
                self.customView.collectionView.reloadData()
            }
        }
    }

}

private typealias UISetup = GalleryViewController
private extension UISetup {
    
    func setupNavBar() {
        title = "Flickr Gallery"
        navigationController?.navigationBar.barTintColor = .paleOrangeColor()
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }
}

private typealias CollectionViewDataHandler = GalleryViewController
extension CollectionViewDataHandler: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosModel?.photos?.allPhotos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryItemCollectionViewCell,
              let photoModel = viewModel.photosModel else { return UICollectionViewCell() }
        cell.setupContent(title: photoModel.photos?.allPhotos[indexPath.item].title ?? "")
        return cell
    }
    
}

private typealias CollectionViewLayoutHandler = GalleryViewController
extension CollectionViewLayoutHandler: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 16
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}
