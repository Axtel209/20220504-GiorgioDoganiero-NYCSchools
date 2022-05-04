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
        configureDataSource()
        customView.tableView.prefetchDataSource = self
        customView.tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
                self.updateUI(for: state)
            })
            .store(in: &subscribers)
    }
    
    private func updateUI(for state: MainViewModel.UIState) {
        switch state {
        case .isLoading(let isLoading):
            if isLoading {
                showLoadingOverlay()
            } else {
                hideLoadingOverlay()
            }
        case .failed(let error):
            print("#### error: \(error)")
        case .loaded(let schools):
            // avoid animation on initial load
            let animated = dataSource.snapshot().numberOfItems > 0
            updateSchools(schools, animated: animated)
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
            cell.schoolNameLabel.text = school.name
            cell.addressLabel.text = school.shortAddress
            cell.gradesLabel.text = String(format:"school_detail_item_levels".localized, school.grades)
            cell.busOptionsView.isSelected = school.hasBus
            cell.subwayOptionsView.isSelected = school.hasSubway
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
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        // TODO: Implement a prefetch canceling, not a deal breaker for MVP
    }
}

// MARK: - UITableViewDelegate
extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Handle error case
        guard let selectedSchool = dataSource.itemIdentifier(for: indexPath) else { return }
        
        let viewModel = SchoolDetailsViewModel(selectedSchool)
        let controller = SchoolDetailsController(viewModel)
        controller.modalPresentationStyle = .fullScreen
        
        present(controller, animated: true)
    }
}
