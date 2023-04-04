//
//  CitiesCell.swift
//  Hammer
//
//  Created by Kuat Bodikov on 04.04.2023.
//

import UIKit

protocol CitiesCellModelRepresentable {
    var viewModel: CitiesCellIdentifiable? { get set }
}

final class CitiesCell: UITableViewCell, CitiesCellModelRepresentable {
    static let identifire = "CitiesCell"

    private let cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    var viewModel: CitiesCellIdentifiable? {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel as? CitiesCellViewModel else { return }
        cityName.text = viewModel.cityName

        contentView.addSubview(cityName)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
