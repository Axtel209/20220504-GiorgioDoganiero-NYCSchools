//
//  SchoolDetailsController.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import UIKit
import Combine

class SchoolDetailsController: MVVMViewController<SchoolDetailsViewModel, SchoolDetailsView> {
    // MARK: - Propesties
    private var subscribers: [AnyCancellable] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    // MARK: - Setup
    private func setupViews() {
        customView.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        customView.addressButton.addTarget(self, action: #selector(addressButtonAction), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                guard let self = self,
                      let state = state else {
                    return
                }
                
                self.updateUI(for: state)
            })
            .store(in: &subscribers)
    }
    
    private func updateUI(for state: SchoolDetailsViewModel.UIState) {
        switch state {
        case .ready(let school):
            customView.titleLabel.text = school.name
            customView.addressButton.configuration?.title = school.shortAddress
            customView.descriptionTextView.text = school.description
            customView.gradesLabel.text = String(format: "school_detail_item_levels".localized, school.grades)
            customView.studentsLabel.text = String(format: "school_detail_item_students".localized, school.totalStudents)
            customView.websiteButton.configuration?.title = school.website
            
            if let sat = school.satScores {
                customView.criticalReadingLabel.text = String(format: "school_detail_item_critical_reading".localized, sat.readingAvgScore)
                customView.mathLabel.text = String(format: "school_detail_item_math".localized, sat.mathAvgScore)
                customView.writingLabel.text = String(format: "school_detail_item_writing".localized, sat.writingAvgScore)
            } else {
                customView.criticalReadingLabel.text = "school_detail_item_no_scores".localized
            }
            
        }
    }
    
    // MARK: - Actions
    @objc private func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func addressButtonAction(_ sender: UIButton) {
        viewModel.openMaps()
    }
}
