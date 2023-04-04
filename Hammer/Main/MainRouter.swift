//
//  MainRouter.swift
//  Hammer
//
//  Created by Kuat Bodikov on 04.04.2023.
//

import UIKit

protocol MainRouterInputProtocol {
    func openCitiesPopOver(cities: [Cities], delegate: CitiesDelegate)
}

final class MainRouter: MainRouterInputProtocol {
    
    weak var view: MainViewController?
    
    
    func openCitiesPopOver(cities: [Cities], delegate: CitiesDelegate) {
        let configurator: CitiesConfiguratorInputProtocol = CitiesConfigurator()
        let citiesVC = configurator.configure(cities: cities, delegate: delegate)
        
        citiesVC.modalPresentationStyle = .popover
        
        let optionalSize: CGFloat = 300
        
        let cityButton = view?.cityButton
        let popOver = citiesVC.popoverPresentationController
        popOver?.delegate = view
        popOver?.sourceView = cityButton
        citiesVC.preferredContentSize = CGSize(width: (view?.view.frame.size.width ?? optionalSize) - 50, height: (view?.view.frame.size.height ?? optionalSize) - 50)
        view?.present(citiesVC, animated: true)
        
    }
}
