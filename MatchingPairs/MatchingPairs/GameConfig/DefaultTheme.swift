//
//  Theme.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import SwiftUI

func getDefaultTheme() -> Theme? {
    var themes: [Theme] = []
    let jsonData = """
            [
                {
                    "card_color": {
                        "blue": 0.01,
                        "green": 0.549,
                        "red": 0.9686
                    },
                    "card_symbol": "🍬",
                    "symbols": [
                        "🎃",
                        "👻",
                        "👿",
                        "💀",
                        "🧟‍♀️",
                        "🐈‍⬛"
                    ],
                    "title": "Boo"
                },
                {
                    "card_color": {
                        "blue": 0.549,
                        "green": 0.8667,
                        "red": 0.949
                    },
                    "card_symbol": "🎈",
                    "symbols": [
                        "🔴",
                        "🔵",
                        "🟠",
                        "🟡",
                        "🟢",
                        "🟣"
                    ],
                    "title": "Balloons"
                }
            ]
        """.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    do {
        themes = try decoder.decode([Theme].self, from: jsonData)
    } catch {
        print("Error decoding JSON: \(error)")
    }
    return themes.first
}
