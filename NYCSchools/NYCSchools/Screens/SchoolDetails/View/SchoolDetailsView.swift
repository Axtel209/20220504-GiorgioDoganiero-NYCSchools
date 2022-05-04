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
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var addressButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .small
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var educationSectionView: SchoolDetailSectionView = {
        let view = SchoolDetailSectionView()
        view.titleLabel.text = "school_detail_section_education".localized
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var educationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var gradesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var studentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var websiteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .small
        config.baseForegroundColor = .blue
        config.titleAlignment = .leading
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var satSectionView: SchoolDetailSectionView = {
        let view = SchoolDetailSectionView()
        view.titleLabel.text = "school_detail_section_sat".localized
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var satScoresStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var criticalReadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var mathLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var writingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var contactButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.baseBackgroundColor = .systemPurple
        config.baseForegroundColor = .white
        config.title = "school_detail_contact_us".localized
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(descriptionTextView)
        addSubview(educationSectionView)
        addSubview(educationStackView)
        educationStackView.addArrangedSubview(gradesLabel)
        educationStackView.addArrangedSubview(studentsLabel)
        addSubview(satSectionView)
        addSubview(satScoresStackView)
        satScoresStackView.addArrangedSubview(criticalReadingLabel)
        satScoresStackView.addArrangedSubview(mathLabel)
        satScoresStackView.addArrangedSubview(writingLabel)
        addSubview(contactButton)
        
        NSLayoutConstraint.activate([
            headerBanner.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            headerBanner.topAnchor.constraint(equalTo: topAnchor),
            headerBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: headerBanner.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerBanner.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: addressButton.topAnchor, constant: -8),
            
            addressButton.leadingAnchor.constraint(equalTo: headerBanner.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressButton.trailingAnchor.constraint(lessThanOrEqualTo: headerBanner.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addressButton.bottomAnchor.constraint(equalTo: headerBanner.bottomAnchor, constant: -16),
            
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18),
            descriptionTextView.topAnchor.constraint(equalTo: headerBanner.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            educationSectionView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            educationSectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            educationSectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            educationStackView.topAnchor.constraint(equalTo: educationSectionView.bottomAnchor, constant: 12),
            educationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            educationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            satSectionView.topAnchor.constraint(equalTo: educationStackView.bottomAnchor, constant: 16),
            satSectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            satSectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            satScoresStackView.topAnchor.constraint(equalTo: satSectionView.bottomAnchor, constant: 12),
            satScoresStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            satScoresStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            contactButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            contactButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contactButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contactButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupThemeColor() {
        backgroundColor = .systemBackground
        headerBanner.backgroundColor = .systemPurple
        titleLabel.textColor = .white
        descriptionTextView.backgroundColor = .systemBackground
        descriptionTextView.textColor = .label
        gradesLabel.textColor = .systemGray2
        studentsLabel.textColor = .systemGray2
        criticalReadingLabel.textColor = .systemGray2
        mathLabel.textColor = .systemGray2
        writingLabel.textColor = .systemGray2
    }
}
