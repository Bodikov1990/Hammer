//
//  CinemasCellViewModel.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

protocol CinemasCellIdentifiable {
    
}

protocol CinemasCellItemRepresentable {
    var items: [CinemasCellIdentifiable] { get set }
}

struct CinemasCellSectionViewModel: CinemasCellItemRepresentable {
    var items: [CinemasCellIdentifiable] = []
}

struct CinemasCellViewModel: CinemasCellIdentifiable {
    
    let cinemaName: String
    
    init(cinemaName: String) {
        self.cinemaName = cinemaName
    }
    
}
