//
//  MainPresenter.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

final class MainPresenter: MainViewOutputProtocol {

    weak var view: MainViewInputProtocol?
    
    private let interactor: MainInteractorInputProtocol
    private let router: MainRouterInputProtocol
    
    private var cities: [Cities] = []
    private var cinemas: [Cinema] = []
    
    init(interactor: MainInteractorInputProtocol, router: MainRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.getBannerImg()
        interactor.fetchData()
    }
    
    func changeCity() {
        interactor.getCities(from: cities)
    }

}

extension MainPresenter: MainInteractorOutputProtocol {
    func bannerImgDidreceive(from banner: [BannerImage]) {
        
        var bannerSection = BannerCellSectionViewModel()
        
        banner.forEach{
            let bannerViewModel = BannerCellViewModel(imgName: $0.rawValue)
            bannerSection.items.append(bannerViewModel)
        }
        
        view?.bannerReloadData(bannerSection: bannerSection)
    }
    
    func scheduleDidReceive(from schedule: [String : Cities]?) {
        guard let schedule = schedule else { return }
        
        let sortedSchedule = schedule.sorted(by: {$0.0 < $1.0} )
        sortedSchedule.forEach{ _, cities in
            self.cities.append(cities)
        }
        showCityName()
    }

    func citiesDidReceive(cities: [Cities]) {
        router.openCitiesPopOver(cities: cities, delegate: self)
    }
}

extension MainPresenter: CitiesDelegate {
    func getCinemaShedule(name: String, uuid: String) {
        view?.showCityName(name: name)
        
        let selectedCity = self.cities.first { $0.uuid == uuid }
        guard let cinemas = selectedCity?.cinemas else { return }
        let sortedCinemas = cinemas.sorted(by: {$0.0 < $1.0} )
        self.cinemas.removeAll()
        sortedCinemas.forEach{ self.cinemas.append($0.value) }
        
        var cinemasSection = CinemasCellSectionViewModel()
        
        self.cinemas.forEach { cinema in
            
            let cinemasViewModel = CinemasCellViewModel(cinemaName: cinema.name ?? "")
            cinemasSection.items.append(cinemasViewModel)
        }
        
        view?.cinemasReloadDate(cinemasSection: cinemasSection)

        mainSectionReload()
    }
}

extension MainPresenter {
    
    private func showCityName() {
        let cityName = cities.first?.name ?? ""
        view?.showCityName(name: cityName)
        
        let cityUUID = cities.first?.uuid ?? ""
        let selectedCity = self.cities.first { $0.uuid == cityUUID }
        guard let cinemas = selectedCity?.cinemas else { return }
        let sortedCinemas = cinemas.sorted(by: {$0.0 < $1.0} )
        self.cinemas.removeAll()
        sortedCinemas.forEach{ self.cinemas.append($0.value) }
        
        var cinemasSection = CinemasCellSectionViewModel()
        
        self.cinemas.forEach { cinema in
            
            let cinemasViewModel = CinemasCellViewModel(cinemaName: cinema.name ?? "")
            cinemasSection.items.append(cinemasViewModel)
        }
        
        view?.cinemasReloadDate(cinemasSection: cinemasSection)
        mainSectionReload()
    }
    
    private func mainSectionReload() {
        var mainSections = [MainSectionViewModel]()
        
        self.cinemas.forEach { cinema in
            var mainSection = MainSectionViewModel(cinemaName: cinema.name ?? "")
            cinema.movies?.values.forEach({ movie in
                let mainCellViewModel = MainCellViewModel(movie: movie)
                mainSection.rows.append(mainCellViewModel)
            })
            mainSections.append(mainSection)
        }
        
        view?.mainReloadData(mainsections: mainSections)
    }
}
