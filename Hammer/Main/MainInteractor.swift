//
//  MainInteractor.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

protocol MainInteractorInputProtocol: AnyObject {
    func getBannerImg()
    func fetchData()
    func getCities(from cities: [Cities])
}

protocol MainInteractorOutputProtocol: AnyObject {
    func scheduleDidReceive(from schedule: [String: Cities]?)
    func bannerImgDidreceive(from banner: [BannerImage])
    func citiesDidReceive(cities: [Cities])
}

final class MainInteractor: MainInteractorInputProtocol {
    
    weak var presenter: MainInteractorOutputProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getBannerImg() {
        let bannerImg = BannerImage.allCases
        presenter?.bannerImgDidreceive(from: bannerImg)
    }
    
    func fetchData() {
        networkManager.fetch(dataType: Afisha.self) { result in
            switch result {
            case .success(let success):
                self.presenter?.scheduleDidReceive(from: success.data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getCities(from cities: [Cities]) {
        presenter?.citiesDidReceive(cities: cities)
    }
}
