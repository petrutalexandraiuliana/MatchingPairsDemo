//
//  WelcomeScreen.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import SwiftUI

struct WelcomeScreen: View {
    
    let startGameAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Welcome to Matching Pairs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Test Your Memory! 🚀🤔")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.red)

            
            Spacer()
            Button(action: startGameAction) {
                Text("Proceed to the game")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(startGameAction: {})
    }
}
