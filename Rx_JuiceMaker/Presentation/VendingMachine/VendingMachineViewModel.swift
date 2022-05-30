//
//  VendingMachineViewModel.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/29.
//

import Foundation
import RxSwift
import RxCocoa

final class VendingMachineViewModel: ViewModelType {

    struct Input {

        let strawberryBananaJuiceOrderButtonTapped: Driver<Void>
        let strawberryJuiceOrderButtonTapped: Driver<Void>
        let bananaJuiceOrderButtonTapped: Driver<Void>
        let pineappleJuiceOrderButtonTapped: Driver<Void>
        let kiwiJuiceOrderButtonTapped: Driver<Void>
        let mangoJuiceOrderButtonTapped: Driver<Void>
        let mangoKiwiJuiceOrderButtonTapped: Driver<Void>
    }

    struct Output {

        let strawberryStock: Driver<String>
        let bananaStock: Driver<String>
        let pineappleStock: Driver<String>
        let kiwiStock: Driver<String>
        let mangoStock: Driver<String>
        let juiceOrderedMessageAction: Signal<String>
    }

    var disposeBag = DisposeBag()

    private let juiceMaker = JuiceMaker()

    func transform(input: Input) -> Output {
        let strawberryBananaJuiceOrderResult = input.strawberryBananaJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.strawberryBanana)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let strawberryJuiceOrderResult = input.strawberryJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.strawberry)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let bananaJuiceOrderResult = input.bananaJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.banana)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let pineappleJuiceOrderResult = input.pineappleJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.pineapple)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let kiwiJuiceOrderResult = input.kiwiJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.kiwi)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let mangoJuiceOrderResult = input.mangoJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.mango)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let mangoKiwiJuiceOrderResult = input.mangoKiwiJuiceOrderButtonTapped
            .flatMap { _ in
                self.juiceMaker.makeJuice(.mangoKiwi)
                    .asDriver(onErrorJustReturn: .failure)
            }

        let orderResults = Driver.merge(
            strawberryBananaJuiceOrderResult,
            strawberryJuiceOrderResult,
            bananaJuiceOrderResult,
            pineappleJuiceOrderResult,
            kiwiJuiceOrderResult,
            mangoJuiceOrderResult,
            mangoKiwiJuiceOrderResult
        )

        let juiceOrderedMessageAction = orderResults.map { result -> String in
            switch result {
            case .success(let juice):
                return "\(juice.menuName)\(VendingMachineMessage.successJuiceMade)"
            case .failure:
                return VendingMachineMessage.OutOfStock
            }
        }.asSignal(onErrorJustReturn: VendingMachineMessage.unknownError)

        let strawberryStock = orderResults.flatMap { _ in
            self.read(stock: .strawberry)
                .asDriver(onErrorJustReturn: DefaultValue.fruitStock)
        }.map { number in
            String(number)
        }

        let bananaStock = orderResults.flatMap { _ in
            self.read(stock: .banana)
                .asDriver(onErrorJustReturn: DefaultValue.fruitStock)
        }.map { number in
            String(number)
        }

        let pineappleStock = orderResults.flatMap { _ in
            self.read(stock: .pineapple)
                .asDriver(onErrorJustReturn: DefaultValue.fruitStock)
        }.map { number in
            String(number)
        }

        let kiwiStock = orderResults.flatMap { _ in
            self.read(stock: .kiwi)
                .asDriver(onErrorJustReturn: DefaultValue.fruitStock)
        }.map { number in
            String(number)
        }

        let mangoStock = orderResults.flatMap { _ in
            self.read(stock: .mango)
                .asDriver(onErrorJustReturn: DefaultValue.fruitStock)
        }.map { number in
            String(number)
        }

        return Output(strawberryStock: strawberryStock,
                      bananaStock: bananaStock,
                      pineappleStock: pineappleStock,
                      kiwiStock: kiwiStock,
                      mangoStock: mangoStock,
                      juiceOrderedMessageAction: juiceOrderedMessageAction)
    }

    private func read(stock fruit: Fruit) -> Observable<Int> {
        self.juiceMaker.read().map { fruitsStock in
            guard let fruitStock = fruitsStock[fruit] else {
                return DefaultValue.fruitStock
            }

            return fruitStock
        }
    }
}

private enum VendingMachineMessage {
    static let successJuiceMade = "가 성공적으로 만들어졌습니다"
    static let OutOfStock = "재고가 부족하여 쥬스를 만들지 못했습니다"
    static let unknownError = "알 수 없는 오류가 발생했습니다"
}

private enum DefaultValue {
    static let fruitStock = 10
}

// 제한 오퍼레이터 모음
// zip, withLatestFrom, take, combineLatest, merge, do, flatMap, filter, map, skip, share, observeOn,
// compactMap, distinctUntilChanged, flatMapLatest, create, of, just, from, retry, ifEmpty
