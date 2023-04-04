//
//  CinemasCell.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import UIKit

protocol CinemasCellModelRepresentable {
    var viewModel: CinemasCellIdentifiable? { get set }
}

final class CinemasCell: UICollectionViewCell, CinemasCellModelRepresentable {
    static let identifiere = "CinemasCell"
    
    var viewModel: CinemasCellIdentifiable? {
        didSet {
            updateView()
        }
    }
    
    private let cinemaNameLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private func updateView() {
        guard let viewModel = viewModel as? CinemasCellViewModel else { return }
        
        cinemaNameLabel.text = viewModel.cinemaName
        
        setupContentView()
        setupConstraints()
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 1
        [
            cinemaNameLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cinemaNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cinemaNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
