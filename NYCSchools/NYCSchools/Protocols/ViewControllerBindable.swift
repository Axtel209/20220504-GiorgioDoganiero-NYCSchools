//
//  ViewControllerBindable.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation

/// Binds the view model and view to the respective view controller
protocol ViewControllerBindable {
    associatedtype ViewModel
    associatedtype CustomView

    var viewModel: ViewModel { get }
    var customView: CustomView { get }
}
