//
//  GalleryView.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//

import UIKit

class GalleryView: UIView {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "What do you want to see?"
        textField.keyboardType = .default
        textField.returnKeyType = .search
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.customBlueColor().cgColor
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .customBlueColor()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.customBlueColor().cgColor
        return button
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customBlueColor()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let emptyContentLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "Oops! No data found.\nPlease try another keyword."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customBlueColor()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GalleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(textField)
        addSubview(searchButton)
        addSubview(collectionView)
        addSubview(loadingLabel)
        addSubview(emptyContentLabel)
        
        NSLayoutConstraint.activate([
            
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalPadding),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.horizontalPadding),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            textField.heightAnchor.constraint(equalToConstant: Constants.componentHeight),
            
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.verticalPadding),
            searchButton.heightAnchor.constraint(equalToConstant: Constants.componentHeight),
            searchButton.widthAnchor.constraint(equalToConstant: Constants.componentHeight * 2),
            searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: Constants.verticalPadding),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            emptyContentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyContentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private typealias Constant = GalleryView
private extension Constant {
    
    struct Constants {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 32
        static let componentHeight: CGFloat = 50
    }
}
