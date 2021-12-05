//
//  YellowCoordinator.swift
//  CoordinatorDemo
//
//  Created by Tuan Tu Do on 05.12.2021.
//

import Combine
import Coordinator
import UIKit

final class YellowCoordinator: Coordinating {
    lazy var presentable: UIViewController = {
        viewController
    }()

    let childCoordinatorsStorage: CoordinatorStoring = CoordinatorStorage()
    let router: Routing

    private lazy var viewController = YellowViewController()
    private var cancellables = Set<AnyCancellable>()

    init(router: Routing) {
        self.router = router
    }

    func start(with input: CoordinationInput) -> AnyPublisher<CoordinationResult, Never> {
        viewController.closeButtonTapped
            .first()
            .map { CoordinationResult.closed }
            .eraseToAnyPublisher()
    }
}

extension YellowCoordinator {
    struct CoordinationInput {}

    enum CoordinationResult {
        case closed
    }
}
