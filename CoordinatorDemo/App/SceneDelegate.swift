//
//  SceneDelegate.swift
//  CoordinatorDemo
//
//  Created by Tuan Tu Do on 05.12.2021.
//

import Combine
import CombineExtensions
import Coordinator
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var router = Router()
    private lazy var appCoordinator = AppCoordinator(router: router)
    private var cancellables = Set<AnyCancellable>()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        appCoordinator.start(with: .init(window: window))
            .sink()
            .store(in: &cancellables)
    }
}
