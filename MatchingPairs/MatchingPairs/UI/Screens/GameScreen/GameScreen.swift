//
//  GameScreen.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import SwiftUI

struct GameScreen: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            switch viewModel.gameState {
            case .win:
                VStack {
                    Text("You Win!!!!!")
                        .font(.title)
                }
            case .lose:
                VStack {
                    Text("You Lose!!!")
                        .font(.title)
                        .foregroundColor(.red)
                }
            case .playing:
                gameView
            }
        }
        .navigationTitle(viewModel.theme?.title ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.showConfigScreenAction(viewModel.difficuty) }) {
                    Text("More")
                        .foregroundColor(.blue)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.reset()
                }) {
                    Text(viewModel.gameState == .playing ? "Reset" : "Start")
                        .bold()
                        .foregroundColor(.red)
                }
            }
            
        }
    }
    
    var gameView: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .font(.headline)
            Text("Remaining Time: \(formattedTime(viewModel.remainingTime))")
                        .font(.subheadline)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(viewModel.cards, id: \.id) { card in
                    CardView(card: card)
                        .frame(width: cardSize, height: cardSize) // Adjust card size
                        .onTapGesture {
                            if !viewModel.canFlipMoreCards { return}
                            card.isFlipped.toggle()
                            viewModel.flippedCards.append(card)
                        }
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}

private var cardSize: CGFloat {
    let spacing: CGFloat = 20
    let totalSpacing: CGFloat = spacing * 4 // 3 spaces between 3 columns
    let availableWidth = UIScreen.main.bounds.width - totalSpacing
    let cardWidth = availableWidth / 3
    return cardWidth
}
