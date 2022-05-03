//
//  SchoolDetailsViewModel.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import Foundation
import Combine

class SchoolDetailsViewModel: ObservableObject {
    enum UIState {
        case ready(school: SchoolModel)
    }
    
    // MARK: - Properties
    @Published private(set) var state: UIState!
    private var subscribers: [AnyCancellable] = []
    private var school: SchoolModel! {
        didSet { state = .ready(school: school) }
    }
    
    // MARK: - Lifecycle
    init(_ school: SchoolModel) {
        setSchool(newValue: school)
    }
    
    // A workaround to make sure the property didSet its called on initialization
    private func setSchool(newValue: SchoolModel) {
        self.school = newValue
    }
}
