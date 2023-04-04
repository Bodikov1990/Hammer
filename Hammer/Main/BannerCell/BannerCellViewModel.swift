//
//  BannerCellViewModel.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

protocol BannerCellIdentifiable {
    var cellHeight: Double { get }
}

protocol BannerCellItemRepresentable {
    var items: [BannerCellIdentifiable] { get set }
}

struct BannerCellSectionViewModel: BannerCellItemRepresentable {
    var items: [BannerCellIdentifiable] = []
}

struct BannerCellViewModel: BannerCellIdentifiable {

    var cellHeight: Double {
        100
    }
    
    let imgName: String
    
    init(imgName: String) {
        self.imgName = imgName
    }
    
}
