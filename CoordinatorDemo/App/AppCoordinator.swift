//
//  AppCoordinator.swift
//  CoordinatorDemo
//
//  Created by Tuan Tu Do on 05.12.2021.
//

import Combine
import CombineExtensions
import Coordinator
import UIKit

final class AppCoordinator: Coordinating {
    let childCoordinatorsStorage: CoordinatorStoring = CoordinatorStorage()
    var presentable: UIViewController { router.navigationController }
    let router: Routing

    private var cancellables = Set<AnyCancellable>()

    init(router: Routing) {
        self.router = router
    }

    func start(with input: CoordinationInput) -> AnyPublisher<CoordinationResult, Never> {
        let viewController = ViewController()
        router.setRootModule(viewController.presentable)

        input.window?.rootViewController = router.navigationController
        input.window?.makeKeyAndVisible()

        handleActions(from: viewController, on: router.navigationController)

        return Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}

private extension AppCoordinator {
    func handleActions(
        from viewModel: ViewController,
        on navigationController: UINavigationController
    ) {
        viewModel.pushButtonTapped
            .flatMap(weak: self) { unwrappedSelf, _ in
                unwrappedSelf.push(
                    OrangeCoordinator(router: unwrappedSelf.router),
                    with: .init(),
                    animated: true
                )
            }
            .filter { result in
                if case .finished = result {
                    return true
                } else {
                    return false
                }
            }
            .eraseType()
            .flatMap(weak: self) { unwrappedSelf, _ in
                unwrappedSelf.pop(animated: true)
            }
            .sink()
            .store(in: &cancellables)

        viewModel.presentButtonTapped
            .flatMap(weak: self) { unwrappedSelf, _ in
                unwrappedSelf.present(
                    YellowCoordinator(router: Router()),
                    with: .init(),
                    animated: true
                )
            }
            .filter { result in
                if case .finished = result {
                    return true
                } else {
                    return false
                }
            }
            .eraseType()
            .flatMap(weak: self) { unwrappedSelf, _ in
                unwrappedSelf.dismiss(animated: true)
            }
            .sink()
            .store(in: &cancellables)
    }
}

extension AppCoordinator {
    struct CoordinationInput {
        let window: UIWindow?
    }

    struct CoordinationResult {}
}
