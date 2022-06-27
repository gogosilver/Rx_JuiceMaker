//
//  Juice.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/25.
//

enum Juice {
    case strawberryBanana
    case strawberry
    case banana
    case pineapple
    case kiwi
    case mango
    case mangoKiwi

    var menuName: String {
        switch self {
        case .strawberryBanana:
            return JuiceName.strawberryBananaJuice
        case .strawberry:
            return JuiceName.strawberryJuice
        case .banana:
            return JuiceName.bananaJuice
        case .pineapple:
            return JuiceName.pineappleJuice
        case .kiwi:
            return JuiceName.kiwiJuice
        case .mango:
            return JuiceName.mangoJuice
        case .mangoKiwi:
            return JuiceName.mangoKiwiJuice
        }
    }

    var ingredients: [(fruit: Fruit, number: Int)] {
        switch self {
        case .strawberryBanana:
            return [(Fruit.strawberry, 10), (Fruit.banana, 1)]
        case .strawberry:
            return [(Fruit.strawberry, 16)]
        case .banana:
            return [(Fruit.banana, 2)]
        case .pineapple:
            return [(Fruit.pineapple, 2)]
        case .kiwi:
            return [(Fruit.kiwi, 3)]
        case .mango:
            return [(Fruit.mango, 3)]
        case .mangoKiwi:
            return [(Fruit.mango, 2), (Fruit.kiwi, 1)]
        }
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
