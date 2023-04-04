//
//  MainConfigurator.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

protocol MainConfiguratorInputProtocol {
    func configure() -> MainViewController
}

final class MainConfigurator: MainConfiguratorInputProtocol {
    func configure() -> MainViewController {

        let networkManager = NetworkManager()
        
        let interactor = MainInteractor(networkManager: networkManager)
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let view = MainViewController(presenter: presenter)

        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
