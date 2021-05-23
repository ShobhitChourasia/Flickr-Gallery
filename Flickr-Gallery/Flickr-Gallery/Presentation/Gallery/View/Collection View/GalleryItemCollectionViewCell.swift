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
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupCell()
        
        addSubview(photoImageView)
        addSubview(photoName)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            photoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photoName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(photo: Photo) {
        photoName.text = photo.title ?? ""
        guard let urlString = ImageUrlFactory(photoModel: photo).getUrl(),
              let url = URL(string: urlString) else { return }
        
        // Fetch Image Data
        utilityQueue.async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

private typealias CellUI = GalleryItemCollectionViewCell
private extension CellUI {
    
    func setupCell() {
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
}
