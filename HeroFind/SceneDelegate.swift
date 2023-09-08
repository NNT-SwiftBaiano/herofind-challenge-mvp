//
//  SceneDelegate.swift
//  HeroFind
//
//  Created by user on 28/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController(rootViewController: ListagemViewController())
        
        window?.rootViewController = navigationController
        
        navigationController.navigationBar.prefersLargeTitles = false
        
        window?.makeKeyAndVisible()
    }


}

