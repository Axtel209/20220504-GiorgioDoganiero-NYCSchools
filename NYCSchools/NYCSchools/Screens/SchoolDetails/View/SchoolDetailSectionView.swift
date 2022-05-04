//
//  SchoolDetailSectionView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/3/22.
//

import UIKit

class SchoolDetailSectionView: UIView {
    private var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(dividerView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalTo: topAnchor),
            dividerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupThemeColor() {
        dividerView.backgroundColor = .systemGray5
        titleLabel.textColor = .label
    }
}
