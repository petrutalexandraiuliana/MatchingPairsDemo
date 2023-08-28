//
//  MatchingPairsCoordinator.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import UIKit
import SwiftUI

final class MatchingPairsCoordinator {
    
    private var window: UIWindow?
    private let navigationController = UINavigationController()
    
    init(window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        let welcomeScreenVC = UIHostingController(rootView: WelcomeScreen(startGameAction: { [weak self] in
            self?.showGameScreen()
        }))
        window?.rootViewController = welcomeScreenVC
    }

    private func showGameScreen() {
        let gameViewModel = GameViewModel()
        gameViewModel.showConfigScreenAction = { [weak self, weak gameViewModel] currentDifficulty in
            self?.showConfigurationScreen(currentDifficulty: currentDifficulty, setupNewGameConfigAction: { newTheme, newDifficulty in
                gameViewModel?.resetWithNewConfiguration(theme: newTheme, difficuty: newDifficulty)
            })
        }
        let gameVC = UIHostingController(rootView: GameScreen(viewModel: gameViewModel))
        window?.rootViewController = navigationController
        navigationController.viewControllers = [gameVC]
    }
    
    private func showConfigurationScreen(currentDifficulty: Difficulty,
                                         setupNewGameConfigAction: @escaping (Theme?, Difficulty) -> Void) {
        let configViewModel = ConfigurationScreenViewModel(themeService: ThemeService(),
                                                           selectedDifficulty: currentDifficulty,
                                                           onDissapearAction: { newTheme, difficulty in
            setupNewGameConfigAction(newTheme, difficulty)
        })
        let configVC = UIHostingController(rootView: ConfigurationScreenView(viewModel: configViewModel))
        let configNavController = UINavigationController()
        configNavController.viewControllers = [configVC]
        navigationController.present(configNavController, animated: true)
    }
    
}

