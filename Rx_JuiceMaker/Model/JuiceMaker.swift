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
                return Result.success
            }
        }
    }

    private func hasSufficientStock(of fruit: Fruit, requiredNumber: Int) -> Observable<Bool> {
        fruitRepository.read(fruit).map { stock in
            stock >= requiredNumber
        }
    }

    private func consumeStock(making juice: Juice) {
        juice.ingredients.forEach { (fruit, number) in
            self.fruitRepository.changeStock(of: fruit, .subtract, number: number)
        }
    }
}

enum Result {

    case success
    case failure
}
