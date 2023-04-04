//
//  MainCell.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import UIKit
import Kingfisher

protocol MainCellModelRepresentable {
    var viewModel: MainCellIdentifiable? { get set }
}

final class MainCell: UITableViewCell, MainCellModelRepresentable {
    static let identifiere = "MainCell"
    
    var viewModel: MainCellIdentifiable? {
        didSet {
            updateView()
        }
    }
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.width,
            height: contentView.frame.height))
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let movieNameLabel = UILabel()
        
        movieNameLabel.numberOfLines = 1
        movieNameLabel.font = .boldSystemFont(ofSize: 12)
        return movieNameLabel
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let pgView: UIView = {
        let view = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 15))
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 3
        view.transform = CGAffineTransform(rotationAngle: 95)
        return view
    }()
    
    private let ageLimitation: UILabel = {
        let label = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 15,
                height: 15))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 8)
        label.textColor = .black
        label.transform = CGAffineTransform(rotationAngle: -95)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private func updateView() {
        guard let viewModel = viewModel as? MainCellViewModel else { return }
        
        if viewModel.imageURL == "" {
            buttonImageView.image = UIImage(named: "fallback")
        } else {
            guard let url = URL(string: viewModel.imageURL) else { return }
            buttonImageView.kf.setImage(with: url)
        }
        
        movieNameLabel.text = viewModel.movieName
        genreLabel.text = viewModel.genre
        durationLabel.text = viewModel.duration
        ageLimitation.text = viewModel.ageLimitation
        
        setupContenView()
        setupConstraints()
    }
    
    private func setupContenView() {
        pgView.addSubview(ageLimitation)
        [
            buttonImageView,
            movieNameLabel,
            genreLabel,
            pgView,
            durationLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            buttonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            buttonImageView.heightAnchor.constraint(equalToConstant: 130),
            buttonImageView.widthAnchor.constraint(equalTo: buttonImageView.heightAnchor, multiplier: 11 / 16),
            
            movieNameLabel.topAnchor.constraint(equalTo: buttonImageView.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: buttonImageView.trailingAnchor, constant: 10),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 30),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            genreLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: 20),
            
            pgView.centerYAnchor.constraint(equalTo: genreLabel.centerYAnchor),
            pgView.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: 10),
            pgView.heightAnchor.constraint(equalToConstant: 16),
            pgView.widthAnchor.constraint(equalTo: pgView.heightAnchor),
            pgView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            ageLimitation.centerYAnchor.constraint(equalTo: pgView.centerYAnchor),
            ageLimitation.centerXAnchor.constraint(equalTo: pgView.centerXAnchor),
            
            durationLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 18),
            durationLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            durationLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}
