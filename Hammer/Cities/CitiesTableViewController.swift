//
//  CitiesTableViewController.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import UIKit

protocol CitiesViewInputProtocol: AnyObject {
    func reloadData(citiesSection: CitiesSectionViewModel)
    
}

protocol CitiesViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func didTapCity(index: Int)
}


class CitiesTableViewController: UITableViewController {
    
    var presenter: CitiesViewOutputProtocol
    
    private var citiesSection: CitiesSectionRowRepresentable = CitiesSectionViewModel()
    
    init(presenter: CitiesViewOutputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.citiesSection.rows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesCell.identifire, for: indexPath) as? CitiesCell else { fatalError() }

        let viewModel = citiesSection.rows[indexPath.row]
        
        cell.viewModel = viewModel

        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(citiesSection.rows[indexPath.row].cellHeight)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCity(index: indexPath.row)
        dismiss(animated: true)
    }

    private func setupTableView() {
        tableView.register(CitiesCell.self, forCellReuseIdentifier: CitiesCell.identifire)
        tableView.frame = view.bounds
    }
}

extension CitiesTableViewController: CitiesViewInputProtocol {
    func reloadData(citiesSection: CitiesSectionViewModel) {
        self.citiesSection = citiesSection
        self.tableView.reloadData()
    }
}
