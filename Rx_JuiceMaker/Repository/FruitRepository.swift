//
//  FruitRepository.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/25.
//

import Foundation
import RxSwift

class FruitRepository {
    
    static let shared = FruitRepository(defaultFruitStock: 10)

    private var stock = [(fruit: Fruit, number: Int)]()

    func read(_ fruit: Fruit) -> Observable<Int> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(RequestError.unknown)

                return Disposables.create()
            }

            let stock = self.stock[fruit.rawValue]
            let number = stock.number

            observer.onNext(number)

            return Disposables.create()
        }
    }

    func changeStock(of fruit: Fruit, _ changement: Changement, number: Int) {
        switch changement {
        case .add:
            self.stock[fruit.rawValue].number += number
        case .subtract:
            self.stock[fruit.rawValue].number -= number
        }
    }

    private init(defaultFruitStock: Int) {
        for fruit in Fruit.allCases {
            stock.append((fruit, defaultFruitStock))
        }
    }
}

enum Changement {

    case add
    case subtract
}

private enum RequestError: Error {

    case unknown
}
