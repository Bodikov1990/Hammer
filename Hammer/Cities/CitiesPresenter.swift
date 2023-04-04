//
//  CitiesPresenter.swift
//  Hammer
//
//  Created by Kuat Bodikov on 04.04.2023.
//

import Foundation

protocol CitiesDelegate: AnyObject {
    func getCinemaShedule(name: String, uuid: String)
}

final class CitiesPresenter: CitiesViewOutputProtocol {
    
    weak var view: CitiesViewInputProtocol?
    weak var delegate: CitiesDelegate?
    
    private let interactor: CitiesInteractorInputProtocol
    private var cities: [Cities] = []
    private var citiesUUID: [String] = []
    init(interactor: CitiesInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.getCities()
    }
    
    func didTapCity(index: Int) {
        let city = cities[index]
        delegate?.getCinemaShedule(name: city.name ?? "", uuid: city.uuid ?? "")
    }
    
}

extension CitiesPresenter: CitiesInteractorOutputProtocol {
    func citiesDidReceive(cities: [Cities]) {
        self.cities = cities
        
        var citiesSection = CitiesSectionViewModel()
        
        cities.forEach {
            
            let citiesViewModel = CitiesCellViewModel(cityName: $0.name ?? "")
            citiesSection.rows.append(citiesViewModel)
        }
        view?.reloadData(citiesSection: citiesSection)
        
    }
    
}


