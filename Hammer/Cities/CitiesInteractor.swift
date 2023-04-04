//
//  CitiesInteractor.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

protocol CitiesInteractorInputProtocol: AnyObject {
    func getCities()
}

protocol CitiesInteractorOutputProtocol: AnyObject {
    func citiesDidReceive(cities: [Cities])
}

final class CitiesInteractor: CitiesInteractorInputProtocol {
    
    weak var presenter: CitiesInteractorOutputProtocol?
    private let cities: [Cities]
    
    init(cities: [Cities]) {
        self.cities = cities
    }
    
    func getCities() {
        
        presenter?.citiesDidReceive(cities: cities)
    }
}
