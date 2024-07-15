//
//  SceneDelegate.swift
//  OlympIt
//
//  Created by Nariman on 18.02.2024.
//

import UIKit

final class SceneDelegate: UIResponder,
                     UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: DashboardRouter.createModule())
        window.makeKeyAndVisible()
        self.window = window
    }
}

private extension SceneDelegate {
    
    func getViewController() -> UIViewController {
        return UINavigationController(rootViewController: DashboardRouter.createModule())
    }
    
}

