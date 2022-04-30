//
//  MVVMViewController.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import UIKit

class MVVMViewController<M, V: UIView>: UIViewController, ViewControllerBindable {
    // MARK: - Properties
    var viewModel: M
    let customView: V

    // MARK: - Lifecycle
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Initializers
    required init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        self.customView = CustomView()
        super.init(nibName: nil, bundle: nil)
    }

    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Must be initialized with init(viewModel:)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
