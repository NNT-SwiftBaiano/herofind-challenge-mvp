//
//  CustomCollectionViewCell.swift
//  HeroFind
//
//  Created by user on 29/08/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identificador = "customCollectionViewCell"
    
    private var hero : Hero?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .systemBlue
        iv.clipsToBounds = true
        return iv
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .white
        
        return label
    }()
        
    public func configure(with hero : Hero) {
        self.hero = hero
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .systemTeal
        
        guard let hero = hero else {
            return
        }
        
        titleLabel.text = hero.name

        imageView.download(from: hero.imageURL)
        
        addViewsInHierarchy()
        setupConstrains()
    }
    
    private func addViewsInHierarchy() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
}
