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
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.customBlueColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.customBlueColor().cgColor
        return button
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightText
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 8?
//        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GalleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleOrangeColor()
        textField.delegate = self

        addSubview(textField)
        addSubview(searchButton)
        addSubview(collectionView)
        addSubview(loadingLabel)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalPadding),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            textField.heightAnchor.constraint(equalToConstant: Constants.componentHeight),
            
            searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.horizontalPadding),
            searchButton.heightAnchor.constraint(equalToConstant: Constants.componentHeight),
            searchButton.widthAnchor.constraint(equalToConstant: Constants.searchButtonWidth),
            searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.horizontalPadding),
            
            collectionView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: Constants.verticalPadding),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.text = textField.text
    }
}

private typealias Constant = GalleryView
private extension Constant {
    
    struct Constants {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 32
        static let componentHeight: CGFloat = 50
        static let searchButtonWidth: CGFloat = 80
    }
}
