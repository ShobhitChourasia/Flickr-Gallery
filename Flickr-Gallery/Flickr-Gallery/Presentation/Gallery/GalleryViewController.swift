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
        setupInitialInterface()
        viewModel = GalleryViewModel()
    }

    //Handle orientation and invalidate flow layout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = customView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    //Hide keyboard when scrolling begins
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        customView.endEditing(true)
    }
    
}

private typealias UIHandler = GalleryViewController
private extension UIHandler {
    
    func setupInitialInterface() {
        customView.textField.delegate = self
        customView.textField.becomeFirstResponder()
        setupNavBar()
        setupCollectionView()
        customView.searchButton.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
    }
    
    func setupNavBar() {
        title = "Flickr Gallery"
        navigationController?.navigationBar.barTintColor = .paleOrangeColor()
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }
    
    @objc func handleSearchButton() {
        customView.textField.resignFirstResponder()
        viewModel.resetPageNumber()
        getImages()
    }
    
    func showEmptyState(isLoading: Bool) {
        DispatchQueue.main.async {
            self.customView.loadingLabel.isHidden = !isLoading
            self.customView.emptyContentLabel.isHidden = isLoading
            self.customView.collectionView.isHidden = true
        }
    }
    
    func reloadResults() {
        DispatchQueue.main.async {
            self.customView.loadingLabel.isHidden = true
            self.customView.emptyContentLabel.isHidden = true
            self.customView.collectionView.isHidden = false
            self.customView.collectionView.reloadData()
        }
    }
    
}

private typealias TextFieldHandler = GalleryViewController
extension TextFieldHandler: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.searchText = textField.text ?? ""
    }
    
}

private typealias GetImages = GalleryViewController
private extension GetImages {
    
    func getImages() {
        if viewModel.currentPageNumber < 2 && customView.collectionView.isHidden {
            showEmptyState(isLoading: true)
        }
        
        viewModel.getImages { [weak self] response in
            guard let self = self,
                  let allPhotos = response?.photos?.allPhotos else { return }
            self.viewModel.isFetchingMoreData = false
            if allPhotos.isEmpty && self.viewModel.currentPageNumber == 1 {
                self.showEmptyState(isLoading: false)
            } else {
                self.reloadResults()
            }
        }
    }
    
}

private typealias CollectionViewDataHandler = GalleryViewController
extension CollectionViewDataHandler: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryView.cellIdentifier, for: indexPath) as? GalleryItemCollectionViewCell else { return UICollectionViewCell() }
        cell.setupContent(photo: viewModel.allPhotos[indexPath.item])
        return cell
    }
    
}

private typealias CollectionViewLayoutHandler = GalleryViewController
extension CollectionViewLayoutHandler: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - (Constants.horizontalPadding * 2)
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: Constants.horizontalPadding,
                     bottom: 0, right: Constants.horizontalPadding)
    }
     
}

private typealias ScrollViewHandler = GalleryViewController
extension ScrollViewHandler: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !viewModel.isFetchingMoreData){
            loadMoreImages()
        }
    }
    
    func loadMoreImages() {
        viewModel.isFetchingMoreData = true
        viewModel.currentPageNumber += 1
        getImages()
    }
    
}


private typealias Constant = GalleryViewController
private extension Constant {
    
    struct Constants {
        static let horizontalPadding: CGFloat = 8
    }
}
