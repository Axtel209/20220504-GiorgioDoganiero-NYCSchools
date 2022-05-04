//
//  MainView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import UIKit

class MainView: UIView {
    // MARK: - Views
    private var bannerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bannerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "school_title_nyc_schools".localized
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        // Cell registration
        tableView.register(SchoolTableViewCell.self)
        
        // View layouts
        addSubview(bannerView)
        addSubview(tableView)
        bannerView.addSubview(bannerTitleLabel)
        
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bannerTitleLabel.topAnchor.constraint(equalTo: bannerView.safeAreaLayoutGuide.topAnchor, constant: 16),
            bannerTitleLabel.leadingAnchor.constraint(equalTo: bannerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bannerTitleLabel.trailingAnchor.constraint(equalTo: bannerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bannerTitleLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: bannerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupThemeColor() {
        backgroundColor = .systemBackground
        bannerView.backgroundColor = .systemPurple
        bannerTitleLabel.textColor = .white
        tableView.backgroundColor = .clear
    }
}
