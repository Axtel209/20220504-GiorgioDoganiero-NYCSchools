//
//  CheckmarkOptionView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//
import UIKit

class CheckmarkOptionView: UIView {
    // MARK: - Views
    var checkmarkImage: UIImageView = {
        let image = UIImage(systemName: "checkmark.seal.fill")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var optionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    var optionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var isSelected: Bool = false {
        willSet {
            checkmarkImage.tintColor = newValue ? .systemGreen : .systemGray3
        }
    }
    
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
        addSubview(optionStackView)
        optionStackView.addArrangedSubview(checkmarkImage)
        optionStackView.addArrangedSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            optionStackView.topAnchor.constraint(equalTo: topAnchor),
            optionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupThemeColor() {
        checkmarkImage.tintColor = .systemGray3
    }
}
