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
        var config = UIButton.Configuration.plain()
        config.buttonSize = .small
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "xmark")
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var addressButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .small
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .label
        config.image = UIImage(systemName: "mappin")
        config.imagePlacement = .leading
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 12)
        
        let button = UIButton(type: .system)
        button.configuration = config
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
        headerBanner.addSubview(titleLabel)
        headerBanner.addSubview(addressButton)
        
        NSLayoutConstraint.activate([
            headerBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            headerBanner.topAnchor.constraint(equalTo: topAnchor),
            headerBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            titleLabel.leadingAnchor.constraint(equalTo: headerBanner.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerBanner.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: addressButton.topAnchor, constant: -8),
            
            addressButton.leadingAnchor.constraint(equalTo: headerBanner.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressButton.trailingAnchor.constraint(lessThanOrEqualTo: headerBanner.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addressButton.bottomAnchor.constraint(equalTo: headerBanner.bottomAnchor, constant: -16),
        ])
    }
    
    private func setupThemeColor() {
        backgroundColor = .systemBackground
    }
}
