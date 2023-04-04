//
//  BannerCell.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import UIKit

protocol BannerCellModelRepresentable {
    var viewModel: BannerCellIdentifiable? { get set }
}

final class BannerCell: UICollectionViewCell, BannerCellModelRepresentable {
    static let identifiere = "BannerCell"
    
    var viewModel: BannerCellIdentifiable? {
        didSet {
            updateView()
        }
    }
    
    private let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private func updateView() {
        
        guard let viewModel = viewModel as? BannerCellViewModel else { return }
        imgView.image = UIImage(named: viewModel.imgName)
        
        setupContentView()
        setupConstraints()
    }
    
    private func setupContentView() {
        [
            imgView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
