//
//  SchoolDetailsController.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import UIKit

class SchoolDetailsController: MVVMViewController<SchoolDetailsViewModel, SchoolDetailsView> {
    // MARK: - Propesties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Setup
    private func setupViews() {
        customView.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
