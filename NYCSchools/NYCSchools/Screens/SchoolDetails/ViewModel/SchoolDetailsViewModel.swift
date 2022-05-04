//
//  SchoolDetailsViewModel.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import Foundation
import Combine
import MapKit

class SchoolDetailsViewModel: ObservableObject {
    enum UIState {
        case ready(school: SchoolModel)
    }
    
    // MARK: - Properties
    @Published private(set) var state: UIState!
    private var subscribers: [AnyCancellable] = []
    private(set) var school: SchoolModel! {
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
    
    // MARK: - Helpers
    
    /// open school address in Apple maps
    func openMaps() {
        let regionDistance: CLLocationDistance = 1000.0
        let coordinates: CLLocationCoordinate2D = .init(latitude: school.coordinates.latitude, longitude: school.coordinates.longitude)
        let regionSpan: MKCoordinateRegion = .init(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = school.name
        mapItem.openInMaps(launchOptions: options)
    }
}
