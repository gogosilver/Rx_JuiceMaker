//
//  ViewModelType.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/05/29.
//

import Foundation
import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
