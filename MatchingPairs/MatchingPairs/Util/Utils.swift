//
//  String+Utils.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import Foundation

func getRandomEmoji(excluding excludedEmojis: [String] = []) -> String {
    let emojiRange = 0x1F600...0x1F64F

    var availableEmojis = Array(emojiRange).map { String(UnicodeScalar($0)!) }
    availableEmojis.removeAll { excludedEmojis.contains($0) }

    guard !availableEmojis.isEmpty else {
        return "😒"
    }

    let randomIndex = Int.random(in: 0..<availableEmojis.count)
    return availableEmojis[randomIndex]
}

func formattedTime(_ timeInterval: TimeInterval) -> String {
     let minutes = Int(timeInterval) / 60
     let seconds = Int(timeInterval) % 60
     return "\(minutes) minutes \(seconds) seconds"
 }
