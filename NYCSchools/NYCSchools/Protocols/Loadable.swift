//
//  Loadable.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import UIKit

protocol Loadable: AnyObject {
    var loadingOverlay: UIView? { get set }
}

extension Loadable where Self: UIViewController {
    private func newLoadingOverlay() -> UIView {
        let backgroundView = UIView(frame: view.frame)
        backgroundView.backgroundColor = .systemGray4
        backgroundView.alpha = 0.3
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let spinnerBackground = UIView()
        spinnerBackground.backgroundColor = .systemBackground
        spinnerBackground.layer.cornerRadius = 10
        spinnerBackground.layer.masksToBounds = true
        spinnerBackground.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(spinnerBackground)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .systemGray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinnerBackground.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            // Spinner Background
            spinnerBackground.widthAnchor.constraint(equalToConstant: 80),
            spinnerBackground.heightAnchor.constraint(equalToConstant: 80),
            spinnerBackground.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            spinnerBackground.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            // Spinner
            spinner.centerXAnchor.constraint(equalTo: spinnerBackground.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: spinnerBackground.centerYAnchor),
        ])

        
        return backgroundView
    }
    
    func showLoadingOverlay() {
        DispatchQueue.main.async {
            guard self.loadingOverlay == nil else { return }
            
            // It's ok to force unwrap since we have it initialized
            self.loadingOverlay = self.newLoadingOverlay()
            self.view.addSubview(self.loadingOverlay!)
            
            NSLayoutConstraint.activate([
                self.loadingOverlay!.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.loadingOverlay!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                self.loadingOverlay!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.loadingOverlay!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            ])
        }
    }
    
    func hideLoadingOverlay() {
        DispatchQueue.main.async {
            guard let _ = self.loadingOverlay else { return }
            self.loadingOverlay?.removeFromSuperview()
            self.loadingOverlay = nil
        }
    }
}
