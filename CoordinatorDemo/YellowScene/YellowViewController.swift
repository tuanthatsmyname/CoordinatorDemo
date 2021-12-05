//
//  YellowViewController.swift
//  CoordinatorDemo
//
//  Created by Tuan Tu Do on 05.12.2021.
//

import Combine
import UIKit

final class YellowViewController: UIViewController {
    let closeButtonTapped = PassthroughSubject<Void, Never>()

    override func viewDidLoad() {
        view.backgroundColor = .yellow

        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(onCloseButtonTap), for: .touchUpInside)

        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc private func onCloseButtonTap() {
        closeButtonTapped.send()
    }
}
