//
//  FruitRepository.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/25.
//

import Foundation
import RxSwift

final class FruitRepository {
    
    static let shared = FruitRepository(defaultFruitStock: DefaultValue.fruitStock)

    private var stock: BehaviorSubject<[(fruit: Fruit, number: Int)]>

    private init(defaultFruitStock: Int) {
        var stock = [(fruit: Fruit, number: Int)]()

        for fruit in Fruit.allCases {
            stock.append((fruit, defaultFruitStock))
        }

        self.stock = BehaviorSubject(value: stock)
    }

    func read(_ fruit: Fruit) -> Observable<Int> {
        self.stock.map { stock in
            stock[fruit.rawValue].number
        }
    }

    func changeStock(of fruit: Fruit, number: Int) {
        do {
            var stock = try self.stock.value()
            stock[fruit.rawValue].number += number

            self.stock.onNext(stock)
        } catch {
            return
        }
    }
}

private enum DefaultValue {

    static let fruitStock = 10
}
