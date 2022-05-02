//
//  SchoolDetailsView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import UIKit

class SchoolDetailsView: UIView {
    // MARK: - Views
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupThemeColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        // View layouts
        NSLayoutConstraint.activate([
        ])
    }
    
    private func setupThemeColor() {
        backgroundColor = .white
    }
}
