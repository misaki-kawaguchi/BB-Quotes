//
//  Character.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/12.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
