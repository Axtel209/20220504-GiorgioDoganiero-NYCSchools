//
//  String+Localized.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/3/22.
//

import Foundation

extension String {
    private func localizedString(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: self.replacingOccurrences(of: "\"", with: "") , comment: "")
    }
    
    // Access the localized string
    var localized: String {
        var localized = localizedString()
     
        // If it doesn't find a translation uses the base string
        // If the base string doesn't exists returns the key
        if self == localized, let fallBackBundlePath = Bundle.main.path(forResource: "Base", ofType: "lproj"), let fallBackBundle = Bundle(path: fallBackBundlePath) {
            localized = fallBackBundle.localizedString(forKey: self, value: "", table: nil)
        }
        
        return localized
    }
}
