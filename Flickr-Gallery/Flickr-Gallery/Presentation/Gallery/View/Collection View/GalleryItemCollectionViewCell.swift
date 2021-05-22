//
//  GalleryItemCollectionViewCell.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    private let photoName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightText
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupCell()
        
        addSubview(photoName)
        addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            photoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photoName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(title: String) {
        photoName.text = title
    }
}

private typealias CellUI = GalleryItemCollectionViewCell
private extension CellUI {
    
    func setupCell() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
