//
//  ViewController.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import UIKit
import Combine

class MainController: MVVMViewController<MainViewModel, MainView>, Loadable {
    // MARK: - Properties
    private var subscribers: [AnyCancellable] = []
    private var dataSource: DataSource!
    var loadingOverlay: UIView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        customView.tableView.prefetchDataSource = self
        configureDataSource()
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
                self.updateUIState(state)
            })
            .store(in: &subscribers)
    }
    
    private func updateUIState(_ state: MainViewModel.UIState) {
        switch state {
        case .isLoading(let isLoading):
            if isLoading {
                showLoadingOverlay()
            } else {
                hideLoadingOverlay()
            }
        case .failed(let error):
            print(error)
        case .loaded(let schools):
            updateSchools(schools, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainController {
    typealias DataSource = UITableViewDiffableDataSource<Int, SchoolModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, SchoolModel>
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: customView.tableView,
                                                   cellProvider: { tableView, indexPath, school in
            let cell: SchoolTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.backgroundColor = .blue
            cell.titelLabel.text = school.name
            return cell
        })
    }
    
    private func updateSchools(_ schools: [SchoolModel], animated: Bool) {
        var snapshot =  Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(schools)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension MainController: UITableViewDataSourcePrefetching {
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (dataSource.snapshot().numberOfItems - 1)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            let offset = dataSource.snapshot().numberOfItems
            viewModel.fetchSchools(offset: offset)
        }
    }
}

