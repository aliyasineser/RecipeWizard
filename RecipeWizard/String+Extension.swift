//
//  String+Extension.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 13.11.2021.
//

import Foundation

extension StringProtocol where Self: RangeReplaceableCollection {
    var removingAllWhitespaces: Self {
        filter(\.isWhitespace.negated)
    }
    mutating func removeAllWhitespaces() {
        removeAll(where: \.isWhitespace)
    }
}


extension Bool {
    var negated: Bool { !self }
}
