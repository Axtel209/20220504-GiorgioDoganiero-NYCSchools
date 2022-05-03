//
//  SchoolDetailsView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import UIKit

class SchoolDetailsView: UIView {
    // MARK: - Views
    private(set) var closeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .small
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "xmark")
        config.imagePlacement = .all
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var headerBanner: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        addSubview(headerBanner)
        headerBanner.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            headerBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            headerBanner.topAnchor.constraint(equalTo: topAnchor),
            headerBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupThemeColor() {
        backgroundColor = .systemBackground
    }
}
