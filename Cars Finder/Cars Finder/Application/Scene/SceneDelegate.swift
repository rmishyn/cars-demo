//
//  SceneDelegate.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 06.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Properties
    
    var window: UIWindow?
    private var sceneDelegateService: SceneDelegateService!
    
    // MARK: Lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            sceneDelegateService = SceneDelegateService(window: window,
                                                        dependenciesResolver: (UIApplication.shared.delegate as! AppDelegate).dependenciesResolver)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
