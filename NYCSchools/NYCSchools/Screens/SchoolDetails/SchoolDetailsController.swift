//
//  SchoolDetailsController.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import UIKit
import Combine

class SchoolDetailsController: MVVMViewController<SchoolDetailsViewModel, SchoolDetailsView> {
    // MARK: - Propesties
    private var subscribers: [AnyCancellable] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    // MARK: - Setup
    private func setupViews() {
        customView.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                guard let self = self,
                      let state = state else {
                    return
                }
                
                self.updateUI(for: state)
            })
            .store(in: &subscribers)
    }
    
    private func updateUI(for state: SchoolDetailsViewModel.UIState) {
        switch state {
        case .ready(let school):
            customView.titleLabel.text = school.name
        }
    }
    
    // MARK: - Actions
    @objc private func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
