//
//  ConfigurationScreenViewModel.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import Combine
import Foundation

final class ConfigurationScreenViewModel: ObservableObject {
    
    @Published var fetchedThemes: [Theme] = []
    
    @Published var selectedTheme: Theme?
    @Published var selectedDifficulty: Difficulty
    
    private let themeService: ThemeService
    
    let onDissapearAction: (_ selectedTheme: Theme?, _ selectedDifficulty: Difficulty) -> Void

    init(themeService: ThemeService,
         selectedDifficulty: Difficulty,
         onDissapearAction: @escaping (Theme?, Difficulty) -> Void) {
        self.themeService = themeService
        self.selectedDifficulty = selectedDifficulty
        self.onDissapearAction = onDissapearAction
        getThemes()
    }
    
    private func getThemes() {
        themeService.fetchThemes { [weak self] themes,errors in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self?.fetchedThemes = themes ?? []
            }
        }
    }
}
