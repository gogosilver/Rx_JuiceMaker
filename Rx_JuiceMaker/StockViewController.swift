//
//  StockViewController.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/22.
//

import UIKit

class StockViewController: UIViewController {

    @IBOutlet weak var closeButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTargetToButton()
    }

    private func addTargetToButton() {
        self.closeButton.action = #selector(closeButtonTapped)
        self.closeButton.target = self
    }

    @objc
    private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}
