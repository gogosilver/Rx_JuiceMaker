//
//  JuiceMaker.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/25.
//

import Foundation
import RxSwift

struct JuiceMaker {

    private let fruitRepository = FruitRepository.shared

    func makeJuice(_ juice: Juice) -> Observable<Result> {
        let possibleStates = Observable.zip(
            juice.ingredients.map { (fruit, number) in
                self.hasSufficientStock(of: fruit, requiredNumber: number)
            }
        )

        return possibleStates.map { possibleState in
            if possibleState.contains(false) {
                return Result.failure
            } else {
                self.consumeStock(making: juice)
                return Result.success(juice)
            }
        }
    }

    func read() -> Observable<[Fruit: Int]> {
        self.fruitRepository.read()
    }

    private func hasSufficientStock(of fruit: Fruit, requiredNumber: Int) -> Observable<Bool> {
        self.read().map { fruitsStock in
            guard let fruitStock = fruitsStock[fruit] else {
                return false
            }

            return fruitStock >= requiredNumber
        }
    }

    private func consumeStock(making juice: Juice) {
        juice.ingredients.forEach { (fruit, number) in
            self.fruitRepository.changeStock(of: fruit, number: -number)
        }
    }
}

enum Result {

    case success(Juice)
    case failure
}
