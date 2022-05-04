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
        customView.contactButton.addTarget(self, action: #selector(contactButtonAction), for: .touchUpInside)
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
    
    @objc private func contactButtonAction(_ sender: UIButton) {
        let alert = buildContactAlert()
        present(alert, animated: true)
    }
    
    // MARK: - Helper
    
    private func buildContactAlert() -> UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: "school_detail_school_contact".localized,
                                      preferredStyle: .actionSheet)
        
        // Phone number always return a non empty String but must double check
        let phone = viewModel.school.phoneNumber
        if !phone.isEmpty, let url = URL(string: "tel://" + phone), UIApplication.shared.canOpenURL(url) {
            let actionCall = UIAlertAction(title: "common_call".localized, style: .default) { _ in
                UIApplication.shared.open(url)
            }
            alert.addAction(actionCall)
        }
        
        // validate email
        if let email = viewModel.school.email, let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
            let actionEmail = UIAlertAction(title: "common_email".localized, style: .default) { _ in
                UIApplication.shared.open(url)
            }
            alert.addAction(actionEmail)
        }
        
        // Website alwyas return a non empty String but must double check
        // TODO: Given more time I would prefer to validate and modify websites prefixes to open all sorts of links form API
        let website = viewModel.school.website
        if !website.isEmpty, let url = URL(string: "https://" + website), UIApplication.shared.canOpenURL(url) {
            let actionWebsite = UIAlertAction(title: "common_website".localized, style: .default) { _ in
                UIApplication.shared.open(url)
            }
            alert.addAction(actionWebsite)
        }
        
        let actionCancel = UIAlertAction(title: "common_cancel".localized, style: .cancel)
        
        
        alert.addAction(actionCancel)
        return alert
    }
}
