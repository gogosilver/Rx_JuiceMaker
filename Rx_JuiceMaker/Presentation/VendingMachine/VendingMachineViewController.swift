//
//  ViewController.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/20.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class VendingMachineViewController: UIViewController {

    @IBOutlet weak var strawBerryBananaJuiceOrderButton: UIStackView!
    @IBOutlet weak var strawberryJuiceOrderButton: UIStackView!
    @IBOutlet weak var bananaJuiceOrderButton: UIStackView!
    @IBOutlet weak var pineappleJuiceOrderButton: UIStackView!
    @IBOutlet weak var kiwiJuiceOrderButton: UIStackView!
    @IBOutlet weak var mangoJuiceOrderButton: UIStackView!
    @IBOutlet weak var mangoKiwiJuiceOrderButton: UIStackView!

    @IBOutlet weak var strawberryStockLabel: UILabel!
    @IBOutlet weak var bananaStockLabel: UILabel!
    @IBOutlet weak var pineappleStockLabel: UILabel!
    @IBOutlet weak var kiwiStockLabel: UILabel!
    @IBOutlet weak var mangoStockLabel: UILabel!

    private let viewModel = VendingMachineViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bind()
    }

    private func bind() {
        let input = VendingMachineViewModel.Input(
            strawberryBananaJuiceOrderButtonTapped: self.strawBerryBananaJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ()),
            strawberryJuiceOrderButtonTapped: self.strawberryJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ()),
            bananaJuiceOrderButtonTapped: self.bananaJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ()),
            pineappleJuiceOrderButtonTapped: self.pineappleJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ()),
            kiwiJuiceOrderButtonTapped: self.kiwiJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ()),
            mangoJuiceOrderButtonTapped: self.mangoJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ()),
            mangoKiwiJuiceOrderButtonTapped: self.mangoKiwiJuiceOrderButton
                .rx
                .tapGesture()
                .when(.recognized)
                .map { _ in }
                .asDriver(onErrorJustReturn: ())
        )

        let output = self.viewModel.transform(input: input)

        output.strawberryStock
            .drive(self.strawberryStockLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.bananaStock
            .drive(self.bananaStockLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.pineappleStock
            .drive(self.pineappleStockLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.kiwiStock
            .drive(self.kiwiStockLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.mangoStock
            .drive(self.mangoStockLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
