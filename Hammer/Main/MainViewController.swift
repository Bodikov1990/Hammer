//
//  MainViewController.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import UIKit


protocol MainViewInputProtocol: AnyObject {
    func bannerReloadData(bannerSection: BannerCellSectionViewModel)
    func cinemasReloadDate(cinemasSection: CinemasCellSectionViewModel)
    func mainReloadData(mainsections: [MainSectionViewModel])
    func showCityName(name: String)
    func didTapCity()
}

protocol MainViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func changeCity()
}

final class MainViewController: UIViewController {

    var presenter: MainViewOutputProtocol
    
    let cityButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
        button.setTitle("Загрузка...", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifiere)
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        
        return tableView
    }()
    
    private let collapsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 1, height: 4)
        view.layer.shadowRadius = 5
        return view
    }()
    
    private let bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifiere)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let cinemasCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CinemasCell.self, forCellWithReuseIdentifier: CinemasCell.identifiere)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    
        return collectionView
    }()
    
    
    private var mainSections: [MainSectionRowRepresentable] = [MainSectionViewModel]()
    private var bannerSection: BannerCellItemRepresentable = BannerCellSectionViewModel()
    private var cinemasSection: CinemasCellItemRepresentable = CinemasCellSectionViewModel()
    
    
    private var collapsViewHeight = NSLayoutConstraint()
    private var bannerCollectionHeight = NSLayoutConstraint()
    private var tableViewTop = NSLayoutConstraint()
    
    
    init(presenter: MainViewOutputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        presenter.viewDidLoad()
        
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        
        cinemasCollectionView.dataSource = self
        cinemasCollectionView.delegate = self
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        
        setupViewSubiew()
        didTapCity()
        setupCollapsSubview()
        setupConstraints()
    }

}


extension MainViewController: MainViewInputProtocol {
    func didTapCity() {
        cityButton.addTarget(self, action: #selector(didTapCityBtn), for: .touchUpInside)
    }
    
    func bannerReloadData(bannerSection: BannerCellSectionViewModel) {
        self.bannerSection = bannerSection
        self.bannerCollectionView.reloadData()
    }
    
    func cinemasReloadDate(cinemasSection: CinemasCellSectionViewModel) {
        self.cinemasSection = cinemasSection
        self.cinemasCollectionView.reloadData()
    }
    
    func mainReloadData(mainsections: [MainSectionViewModel]) {
        self.mainSections = mainsections
        self.mainTableView.reloadData()
    }
    
    func showCityName(name: String) {
        cityButton.setTitle(name, for: .normal)
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.mainSections[section].cinemaName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.mainSections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mainSections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifiere, for: indexPath) as? MainCell else { fatalError() }
        
        let section = mainSections[indexPath.section]
        let cellViewModel = section.rows[indexPath.row]
        
        cell.viewModel = cellViewModel
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(mainSections[indexPath.section].rows[indexPath.row].cellHeight)
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return self.bannerSection.items.count
        }
        return self.cinemasSection.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            
            guard let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifiere, for: indexPath) as?  BannerCell else { fatalError() }
            let viewModel = bannerSection.items[indexPath.item]
            
            cell.viewModel = viewModel
            
            return cell
            
        } else {
            
            guard let cell = cinemasCollectionView.dequeueReusableCell(withReuseIdentifier: CinemasCell.identifiere, for: indexPath) as?  CinemasCell else { fatalError() }
            let viewModel = cinemasSection.items[indexPath.item]
            
            cell.viewModel = viewModel
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cinemasCollectionView {
            let sectionIndex = IndexPath(row: 0, section: indexPath.item)
            print(sectionIndex)
            mainTableView.scrollToRow(at: sectionIndex, at: .top, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
           return CGSize(width: (view.frame.size.width / 2) - 16, height: 70)
        }
        
        return CGSize(width: 230, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == bannerCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -mainTableView.contentOffset.y
        
        if offsetY >= 0 {
            UIView.animate(withDuration: 0.3) {
                self.bannerCollectionView.alpha = 1
                self.collapsViewHeight.constant = 222
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.bannerCollectionView.alpha = 0
                self.collapsViewHeight.constant = 122
            }
        }
    }
}

extension MainViewController {
    
    @objc private func didTapCityBtn() {
        presenter.changeCity()
    }
    
    private func setupViewSubiew() {
        [
            mainTableView,
            collapsView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupCollapsSubview() {
        [
            cityButton,
            bannerCollectionView,
            cinemasCollectionView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            collapsView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        collapsViewHeight = collapsView.heightAnchor.constraint(equalToConstant: 222)
        
        tableViewTop = mainTableView.topAnchor.constraint(equalTo: collapsView.bottomAnchor)
        
        
        NSLayoutConstraint.activate([
            tableViewTop,
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collapsView.topAnchor.constraint(equalTo: view.topAnchor),
            collapsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collapsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collapsViewHeight,
            
            cityButton.topAnchor.constraint(equalToSystemSpacingBelow: collapsView.topAnchor, multiplier: 4),
            cityButton.leadingAnchor.constraint(equalToSystemSpacingAfter: collapsView.leadingAnchor, multiplier: 1),
            cityButton.widthAnchor.constraint(equalToConstant: 150),
            cityButton.heightAnchor.constraint(equalToConstant: 44),
            
            bannerCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: cityButton.bottomAnchor, multiplier: 1),
            bannerCollectionView.leadingAnchor.constraint(equalTo: collapsView.leadingAnchor),
            bannerCollectionView.trailingAnchor.constraint(equalTo: collapsView.trailingAnchor),
            bannerCollectionView.bottomAnchor.constraint(equalTo: cinemasCollectionView.topAnchor),
            
            cinemasCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor),
            cinemasCollectionView.leadingAnchor.constraint(equalTo: collapsView.leadingAnchor),
            cinemasCollectionView.trailingAnchor.constraint(equalTo: collapsView.trailingAnchor),
            cinemasCollectionView.heightAnchor.constraint(equalToConstant: 30),
            cinemasCollectionView.bottomAnchor.constraint(equalTo: collapsView.bottomAnchor, constant: -8)
        ])
    }
    
}

