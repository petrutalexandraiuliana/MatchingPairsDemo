//
//  Difficulty.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import Foundation

enum Difficulty: CaseIterable {
    case easy, medium, hard

    var numberOfCards: Int {
        switch self {
        case .easy:
            return 8
        case .medium:
            return 10
        case .hard:
            return 12
        }
    }
    
    var scoring: Int {
        switch self {
        case .easy:
            return 2
        case .medium:
            return 4
        case .hard:
            return 8
        }
    }
    
    var secondsForSeeingCards: Double {
        switch self {
        case .easy:
            return 2
        case .medium:
            return 1
        case .hard:
            return 0.7
        }
    }
    
    var countDownInterval: TimeInterval {
        switch self {
        case .hard:
            return 60
        case .medium:
            return 180
        case .easy:
            return 300
        }
    }
    
    var title: String {
        switch self {
        case .hard:
            return "Hard"
        case .medium:
            return "Medium"
        case .easy:
            return "Easy"
        }
    }
}
