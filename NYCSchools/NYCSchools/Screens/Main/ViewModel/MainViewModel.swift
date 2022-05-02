//
//  MainViewModel.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    enum UIState {
        case isLoading(_ loading: Bool)
        case failed(error: String)
        case loaded(schools: [School])
    }
    
    // MARK: - Properties
    @Published private(set) var state: UIState = .isLoading(true)
    private var subscribers: [AnyCancellable] = []
    private var schools: [School] = []
    
    // MARK: - Setup
    
    init() {
        fetchSchools()
    }
    
    /// Return schools.
    /// - Parameters:
    ///   - limit: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    func fetchSchools(_ limit: Int = 100, offset: Int = 0) {
        let endpoint = Endpoint.schools(count: limit, offset: offset)

        NetworkService.shared.request(endpoint.url, expecting: [School].self)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                self.state = .isLoading(false)
                if case .failure(let error) = completion {
                    self.state = .failed(error: error.localizedDescription)
                }
            } receiveValue: { [weak self] results in
                guard let self = self else { return }
                
                self.schools.append(contentsOf: results)
                self.state = .loaded(schools: self.schools)
            }
            .store(in: &subscribers)
    }
}
