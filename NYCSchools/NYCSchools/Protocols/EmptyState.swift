//
//  ErrorState.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/4/22.
//

import UIKit

protocol ErrorState: AnyObject {
    var errorOverlay: UIView? { get set }
    var errorAction: UIAction? { get }
}

extension ErrorState where Self: UIViewController {
    private func newEmptyStateView(with title: String?, message: String?) -> UIView {
        let backgroundView = UIView(frame: view.frame)
        backgroundView.backgroundColor = .systemBackground
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        if let title = title {
            let titleLabel = UILabel()
            titleLabel.textColor = .label
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            titleLabel.text = title

            stackView.addArrangedSubview(titleLabel)
        }

        if let message = message {
            let messageLabel = UILabel()
            messageLabel.textColor = .label
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.preferredFont(forTextStyle: .title3)
            messageLabel.text = message

            stackView.addArrangedSubview(messageLabel)
        }

        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.buttonSize = .large
        buttonConfig.baseBackgroundColor = .systemPurple
        buttonConfig.baseForegroundColor = .white
        buttonConfig.title = "common_retry".localized

        let retryButton = UIButton(configuration: buttonConfig, primaryAction: self.errorAction)
        retryButton.configuration = buttonConfig
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        backgroundView.addSubview(stackView)
        backgroundView.addSubview(retryButton)

        NSLayoutConstraint.activate([
            // Content stack view
            stackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),

            // Retry button
            retryButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
        ])

        return backgroundView
    }
    
    func showEmptyStateView(title: String? = nil, message: String? = nil) {
        DispatchQueue.main.async {
            guard self.errorOverlay == nil else { return }
            
            // It's ok to force unwrap since we have it initialized
            self.errorOverlay = self.newEmptyStateView(with: title, message: message)
            self.view.addSubview(self.errorOverlay!)
            
            NSLayoutConstraint.activate([
                self.errorOverlay!.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.errorOverlay!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                self.errorOverlay!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.errorOverlay!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            ])
        }
    }
    
    func hideEmptyStateView() {
        // TODO: Given more time, would like to add a delay to avoid flickering
        DispatchQueue.main.async {
            guard self.errorOverlay != nil else { return }
            self.errorOverlay?.removeFromSuperview()
            self.errorOverlay = nil
        }
    }
}
