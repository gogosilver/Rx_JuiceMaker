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

    private var stock: BehaviorSubject<[Fruit: Int]>

    private init(defaultFruitStock: Int) {
        var stock = [Fruit : Int]()

        for fruit in Fruit.allCases {
            stock.updateValue(DefaultValue.fruitStock, forKey: fruit)
        }

        self.stock = BehaviorSubject(value: stock)
    }

    func read() -> Observable<[Fruit: Int]> {
        self.stock.asObservable()
    }

    func changeStock(of fruit: Fruit, number: Int) {
        do {
            var latestStock = try self.stock.value()

            guard let stockNumber = latestStock[fruit] else {
                return
            }

            let changedStockNumber = stockNumber + number
            latestStock.updateValue(changedStockNumber, forKey: fruit)

            self.stock.onNext(latestStock)
        } catch {
            return
        }
    }
}

private enum DefaultValue {

    static let fruitStock = 10
}
