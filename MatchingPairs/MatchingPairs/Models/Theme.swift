//
//  Theme.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//


import SwiftUI

struct Theme: Decodable {
    private enum CodingKeys: String, CodingKey {
        case cardColor = "card_color"
        case initialSymbol = "card_symbol"
        case emonjis = "symbols"
        case title
    }
    
    let initialSymbol: String
    let cardColor: Color
    let title: String
    let emonjis: [String]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        initialSymbol = try container.decode(String.self, forKey: .initialSymbol)
        emonjis = try container.decode([String].self, forKey: .emonjis)
        title = try container.decode(String.self, forKey: .title)
        
        let cardColorComponents = try container.decode(CardColor.self, forKey: .cardColor)
        cardColor = Color(red: cardColorComponents.red, green: cardColorComponents.green, blue: cardColorComponents.blue)
    }
}

struct CardColor: Decodable {
    let red: Double
    let green: Double
    let blue: Double
}
