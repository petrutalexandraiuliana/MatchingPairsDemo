//
//  ConfigurationScreenView.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import SwiftUI

struct ConfigurationScreenView: View {
    
    @ObservedObject var viewModel: ConfigurationScreenViewModel
        
    var body: some View {
        List {
            Section(header: Text("Difficulty")) {
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    Button(action: {
                        viewModel.selectedDifficulty = difficulty
                    }) {
                        HStack {
                            Text(difficulty.title)
                            Spacer()
                            if viewModel.selectedDifficulty == difficulty {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            themesView
        }.navigationTitle("Change game configuration")
            .onDisappear {
                viewModel.onDissapearAction(viewModel.selectedTheme, viewModel.selectedDifficulty)
            }
    }
    
    var themesView: some View {
        Section(header: Text("Avaliable themes")) {
            ForEach(viewModel.fetchedThemes, id: \.title) { theme in
                Button(action: {
                    viewModel.selectedTheme = theme
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(theme.title)
                                .font(.headline)
                            Text("Symbols:")
                                .bold()
                            Text(theme.emonjis.joined(separator: ", "))
                        }
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                            .opacity(viewModel.selectedTheme?.title ?? "" == theme.title ? 1 : 0)
                        
                    }
                }
            }
        }
    }
}
