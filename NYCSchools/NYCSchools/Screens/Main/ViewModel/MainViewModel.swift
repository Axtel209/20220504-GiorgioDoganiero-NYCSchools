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
        case loaded(schools: [SchoolModel])
    }
    
    // MARK: - Properties
    @Published private(set) var state: UIState = .isLoading(true)
    private var subscribers: [AnyCancellable] = []
    private var schools: [SchoolModel]! {
        didSet { state = .loaded(schools: schools) }
    }
    // MARK: - Setup
    
    init() {
        fetchSchools()
    }
    
    //MARK: - Fetch Data
    
    /// Return schools.
    /// - Parameters:
    ///   - limit: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    func fetchSchools(_ limit: Int = 100, offset: Int = 0) {
        let schoolsData = fetchSchoolsData(limit, offset: offset)
        let satScoresData = fetchSatScoresData(limit, offset: offset)
        
        self.state = .isLoading(true)
        Publishers.Zip(schoolsData, satScoresData)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                self.state = .isLoading(false)
                if case .failure(let error) = completion {
                    self.state = .failed(error: error.localizedDescription)
                }
            } receiveValue: { [weak self] schoolsResults, satScoreResults in
                guard let self = self else { return }
                
                // insert sat scores to schools object
                self.schools = schoolsResults.map { school -> SchoolModel in
                    var tempSchool = school
                    tempSchool.satScores = satScoreResults.filter { $0.dbn == school.dbn }.first
                    return tempSchool
                }
            }
            .store(in: &subscribers)
    }
    
    /// Return schools data.
    /// - Parameters:
    ///   - limit: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    private func fetchSchoolsData(_ limit: Int, offset: Int) -> AnyPublisher<[SchoolModel], Error> {
        let schoolEndpoint = Endpoint.schools(count: limit, offset: offset)
        
        return NetworkService.shared.request(schoolEndpoint.url, expecting: [SchoolModel].self)
    }
    
    /// Return sat score data.
    /// - Parameters:
    ///   - limit: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    private func fetchSatScoresData(_ limit: Int, offset: Int) -> AnyPublisher<[SATScoreModel], Error> {
        let satEndpoint = Endpoint.sat(count: limit, offset: offset)
        
        return NetworkService.shared.request(satEndpoint.url, expecting: [SATScoreModel].self)
    }
}
