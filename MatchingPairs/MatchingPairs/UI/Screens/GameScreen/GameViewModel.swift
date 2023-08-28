//
//  GameViewModel.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import SwiftUI
import Combine
import CardView

enum GameState {
    case playing
    case win
    case lose
}

final class GameViewModel: ObservableObject {
    
    @Published var difficuty: Difficulty = .easy
    @Published var theme: Theme?
    
    @Published var remainingTime: TimeInterval = 300
    @Published var flippedCards: [Card] = []
    @Published var cards: [Card] = []
    @Published var gameState: GameState = .playing

    
    private var countdownTimer: Timer?
    
    var matchedCardsCount: Int {
        cards.filter { $0.isMatched }.count
    }
    
    var canFlipMoreCards: Bool {
        flippedCards.count < 2
    }
    
    var score: String {
        let scoreInt =  matchedCardsCount * difficuty.scoring
        return String(scoreInt)
    }
    
    var showConfigScreenAction: (_ currentDifficulty: Difficulty) -> Void = {_ in}
    
    private var cancellablesSet: Set<AnyCancellable> = Set()
    
    init() {
        
        self.remainingTime = difficuty.countDownInterval
        self.theme = getDefaultTheme()
        
        generateGame()
        $flippedCards
        
            .filter { $0.count == 2 }
            .sink(receiveValue: { [weak self] flippedCards in
                guard let firstCard = flippedCards.first, let lastCard = flippedCards.last else { return}
                guard let self = self else { return}
                DispatchQueue.main.asyncAfter(deadline: .now() + self.difficuty.secondsForSeeingCards) {
                    
                    if firstCard.simbol == lastCard.simbol {
                        firstCard.isMatched = true
                        lastCard.isMatched = true
                    } else {
                        firstCard.isFlipped.toggle()
                        lastCard.isFlipped.toggle()
                    }
                    self.flippedCards.removeAll()
                    
                    if self.matchedCardsCount == self.cards.count && self.remainingTime > 0 {
                        self.gameState = .win
                    }
                }
            }).store(in: &cancellablesSet)
    }
    
    deinit {
        countdownTimer?.invalidate()
    }
    
    func reset() {
        gameState = .playing
        cards.removeAll()
        flippedCards.removeAll()
        countdownTimer?.invalidate()
        remainingTime = difficuty.countDownInterval
        generateGame()
    }
    
    func resetWithNewConfiguration(theme: Theme?, difficuty: Difficulty) {
        self.difficuty = difficuty
        if let newTheme = theme {
            self.theme = newTheme
        }
        reset()
    }
    
    private func generateGame() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
        
        var cardEmojis: [String] = []
        for i in 0..<difficuty.numberOfCards/2 {
            let randomEmonji = getSimbol(index: i, excludingSimbols: cardEmojis)
            cardEmojis.append(randomEmonji)
            cardEmojis.append(randomEmonji)
        }
        cardEmojis.shuffle()
        guard let defaultTheme = theme else { return}
        for i in 0..<difficuty.numberOfCards {
            cards.append(Card(initialSymbol: defaultTheme.initialSymbol, simbol: cardEmojis[i], backgroundColor: defaultTheme.cardColor))
        }
    }
    
    private func getSimbol(index: Int, excludingSimbols: [String]) -> String {
        guard let defaultTheme = theme else { return "?"}
        if defaultTheme.emonjis.count - 1 < index {
            //in case that are not enough symbols
            return getRandomEmoji(excluding: excludingSimbols)
        } else {
            return Array(Set(defaultTheme.emonjis))[index]
        }
    }
    
    private func updateTimer() {
         if remainingTime > 0 {
             remainingTime -= 1
         } else if remainingTime == 0 {
             gameState = .lose
         }
     }
}
