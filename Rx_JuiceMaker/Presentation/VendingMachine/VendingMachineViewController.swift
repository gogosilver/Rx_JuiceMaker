//
//  ViewController.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/20.
//

import UIKit
import RxCocoa

class VendingMachineViewController: UIViewController {
    @IBOutlet weak var strawBerryBananaJuiceOrderButton: UIStackView!
    @IBOutlet weak var strawberryJuiceOrderButton: UIStackView!
    @IBOutlet weak var bananaJuiceOrderButton: UIStackView!
    @IBOutlet weak var pineappleJuiceOrderButton: UIStackView!
    @IBOutlet weak var kiwiJuiceOrderButton: UIStackView!
    @IBOutlet weak var mangoJuiceOrderButton: UIStackView!
    @IBOutlet weak var mangoKiwiJuiceOrderButton: UIStackView!

    private let viewModel = VendingMachineViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

