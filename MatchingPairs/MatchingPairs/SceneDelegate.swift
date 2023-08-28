//
//  SceneDelegate.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var mainCoordinator: MatchingPairsCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.mainCoordinator = MatchingPairsCoordinator(window: window)
        self.mainCoordinator?.start()
        
        windowScene.delegate = self
        
    }
}
