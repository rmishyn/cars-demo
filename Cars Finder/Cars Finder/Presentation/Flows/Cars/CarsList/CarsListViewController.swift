//
//  CarsListViewController.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import SVProgressHUD
import UIKit

@MainActor
final class CarsListViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel: CarsListViewModelProtocol?
    private var bag = CancelBag()
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel else {
            fatalError("'viewModel' is not set in '\(Self.self)'")
        }
        setup(with: viewModel)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Private methods

private extension CarsListViewController {
    
    func setup(with viewModel: CarsListViewModelProtocol) {
        title = viewModel.screenTitle
        navigationItem.title = viewModel.screenTitle
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefreshAction), for: .valueChanged)
        refreshControl.tintColor = .content
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching cars...", attributes: [.foregroundColor: UIColor.content])
    }
    
    func bind(to viewModel: CarsListViewModelProtocol) {
        bag.removeAll()
        viewModel.isLoadingPublisher
            .onMain()
            .sink { [weak self] isLoading in
                self?.updateLoadingStatus(isLoading: isLoading)
            }
            .store(in: &bag)
        viewModel.errorPublisher
            .onMain()
            .sink { error in
                if let error {
                    SVProgressHUD.showError(withStatus: error)
                }
            }
            .store(in: &bag)
        viewModel.carsPublisher
            .onMain()
            .sink { [weak self] cars in
                self?.tableView.reloadData()
            }
            .store(in: &bag)
    }
    
    func updateLoadingStatus(isLoading: Bool) {
        isLoading ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    }
    
    @objc func onRefreshAction() {
        viewModel?.refresh()
    }
}
