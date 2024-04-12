//
//  Constants.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/12.
//

import Foundation

extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
}
