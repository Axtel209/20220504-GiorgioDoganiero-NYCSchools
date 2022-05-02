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
    var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(containerView)
        containerView.addSubview(titelLabel)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 80),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            titelLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            titelLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            titelLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            titelLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
        ])
    }
}
