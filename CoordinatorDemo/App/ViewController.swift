//
//  ViewController.swift
//  CoordinatorDemo
//
//  Created by Tuan Tu Do on 05.12.2021.
//

import Combine
import UIKit

final class ViewController: UIViewController {
    let presentButtonTapped = PassthroughSubject<Void, Never>()
    let pushButtonTapped = PassthroughSubject<Void, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()

        let presentButton = UIButton()
        presentButton.setTitle("Push Orange scene", for: .normal)
        presentButton.addTarget(self, action: #selector(onPushButtonTap), for: .touchUpInside)

        view.addSubview(presentButton)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let pushButton = UIButton()
        pushButton.setTitle("Present Yellow scene", for: .normal)
        pushButton.addTarget(self, action: #selector(onPresentButtonTap), for: .touchUpInside)

        view.addSubview(pushButton)
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.topAnchor.constraint(equalTo: presentButton.bottomAnchor).isActive = true
    }

    @objc private func onPresentButtonTap() {
        presentButtonTapped.send()
    }

    @objc private func onPushButtonTap() {
        pushButtonTapped.send()
    }
}
