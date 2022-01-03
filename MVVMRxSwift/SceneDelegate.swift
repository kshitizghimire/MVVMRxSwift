//
//  SceneDelegate.swift
//  MVVMRxSwift
//
//  Created by Tiz on 25/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let viewModel = ViewModel()
        let viewController = ViewController(viewModel: viewModel)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
