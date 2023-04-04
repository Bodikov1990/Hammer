//
//  CitiesCellViewModel.swift
//  Hammer
//
//  Created by Kuat Bodikov on 04.04.2023.
//

import Foundation

protocol CitiesCellIdentifiable {
    var cellHeight: Double { get }
}

protocol CitiesSectionRowRepresentable {
    var rows: [CitiesCellIdentifiable] { get set }
}

struct CitiesSectionViewModel: CitiesSectionRowRepresentable {
    var rows: [CitiesCellIdentifiable] = []
}

struct CitiesCellViewModel: CitiesCellIdentifiable {
    var cellHeight: Double {
        50
    }
    
    let cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
}
