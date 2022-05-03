//
//  SchoolTableViewCell.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import UIKit

//class WishListTableViewCell: UITableViewCell, ReusableView {
class SchoolTableViewCell: UITableViewCell, ReusableView {
    // MARK: - Views
    private var containerView: RoundShadowView = {
       let view = RoundShadowView()
        view.backgroundColor = .systemBackground
        view.cornerRadius = 12.0
        view.shadowRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var gradesLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var busOptionsView: CheckmarkOptionView = {
        let view = CheckmarkOptionView()
        view.optionLabel.text = "Bus"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var subwayOptionsView: CheckmarkOptionView = {
        let view = CheckmarkOptionView()
        view.optionLabel.text = "Subway"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Avoid shadow clipping
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubview(schoolNameLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(gradesLabel)
        containerView.addSubview(optionsStack)
        optionsStack.addArrangedSubview(busOptionsView)
        optionsStack.addArrangedSubview(subwayOptionsView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            schoolNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            schoolNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            schoolNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            schoolNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            gradesLabel.topAnchor.constraint(equalTo: optionsStack.topAnchor),
            gradesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            gradesLabel.bottomAnchor.constraint(lessThanOrEqualTo: optionsStack.bottomAnchor),
            
            optionsStack.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 12),
            optionsStack.leadingAnchor.constraint(greaterThanOrEqualTo: gradesLabel.trailingAnchor, constant: 8),
            optionsStack.trailingAnchor.constraint(equalTo:containerView.trailingAnchor , constant: -18),
            optionsStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        ])
    }
}
