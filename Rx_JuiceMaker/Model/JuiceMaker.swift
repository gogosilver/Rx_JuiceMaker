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

    func makeJuice(_ juice: JuiceMenu) -> Observable<Result> {
        let possibleStates = Observable.zip(
            juice.ingredients.map { (fruit, number) in
                self.hasSufficientStock(of: fruit, requiredNumber: number)
            }
        )

        return possibleStates.map { possibleState in
            possibleState.contains(false) ? Result.failure : Result.success
        }
    }

    private func hasSufficientStock(of fruit: Fruit, requiredNumber: Int) -> Observable<Bool> {
        fruitRepository.read(fruit).map { stock in
            stock >= requiredNumber
        }
    }
}

enum Result {

    case success
    case failure
}
