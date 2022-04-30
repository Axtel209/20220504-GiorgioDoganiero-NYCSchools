//
//  ReusableView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    /// Creates a unique identifier using a string representing the view.
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
