//
//  MainCellViewModel.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

protocol MainCellIdentifiable {
    var cellHeight: Double { get }
}

protocol MainSectionRowRepresentable {
    var cinemaName: String { get }
    var rows: [MainCellIdentifiable] { get set }
}

struct MainSectionViewModel: MainSectionRowRepresentable {
    var rows: [MainCellIdentifiable] = []
    
    let cinemaName: String
    
    init(cinemaName: String) {
        self.cinemaName = cinemaName
    }
}

final class MainCellViewModel: MainCellIdentifiable {
    
    var cellHeight: Double {
        150
    }
    
    let movieName: String
    let movieUUID: String
    let genre: String
    let duration: String
    let ageLimitation: String
    let imageURL: String
    
    init(movie: Movie) {
        self.movieName = movie.name ?? ""
        self.movieUUID = movie.uuid ?? ""
        self.genre = movie.genre?.joined(separator: ", ") ?? ""
        self.ageLimitation = movie.ageLimit ?? ""
        self.imageURL = movie.images?.vertical ?? ""
        self.duration = "Продолжительность: \(movie.duration ?? 0)"
    }
}
