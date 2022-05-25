//
//  Juice.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/25.
//

import Foundation

protocol JuiceMenu {

    var menuName: String { get }
    var ingredients: [(fruit: Fruit, number: Int)] { get }
}

struct StrawberryBananaJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.strawberryBananaJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.strawberry, 10), (Fruit.banana, 1)]
    }
}

struct StrawberryJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.strawberryJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.strawberry, 16)]
    }
}

struct BananaJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.bananaJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.banana, 2)]
    }
}

struct PineappleJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.pineappleJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.pineapple, 2)]
    }
}

struct KiwiJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.kiwiJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.kiwi, 3)]
    }
}

struct MangoJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.mangoJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.mango, 3)]
    }
}

struct MangoKiwiJuice: JuiceMenu {

    var menuName: String {
        return JuiceName.mangoKiwiJuice
    }
    var ingredients: [(fruit: Fruit, number: Int)] {
        return [(Fruit.mango, 2), (Fruit.kiwi, 1)]
    }
}

private enum JuiceName {
    
    static let strawberryBananaJuice = "딸바쥬스"
    static let strawberryJuice = "딸기쥬스"
    static let bananaJuice = "바나나쥬스"
    static let pineappleJuice = "파인애플쥬스"
    static let kiwiJuice = "키위쥬스"
    static let mangoJuice = "망고쥬스"
    static let mangoKiwiJuice = "망키쥬스"
}
