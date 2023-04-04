//
//  CitiesConfigurator.swift
//  Hammer
//
//  Created by Kuat Bodikov on 04.04.2023.
//

import Foundation

protocol CitiesConfiguratorInputProtocol {
    func configure(cities: [Cities], delegate: CitiesDelegate) -> CitiesTableViewController
}

final class CitiesConfigurator: CitiesConfiguratorInputProtocol {
    func configure(cities: [Cities], delegate: CitiesDelegate) -> CitiesTableViewController {
        
        let interactor = CitiesInteractor(cities: cities)
        let presenter = CitiesPresenter(interactor: interactor)
        let view = CitiesTableViewController(presenter: presenter)

        interactor.presenter = presenter
        presenter.view = view
        presenter.delegate = delegate
        
        return view
    }
}
