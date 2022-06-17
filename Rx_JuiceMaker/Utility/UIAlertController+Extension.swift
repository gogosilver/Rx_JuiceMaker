//
//  UIAlertController+Extension.swift
//  Rx_JuiceMaker
//
//  Created by 고은 on 2022/06/15.
//

import UIKit
import  RxSwift

extension UIAlertController {

    struct AlertAction<Action> {

        var title: String?
        var style: UIAlertAction.Style
        var value: Action

        static func action(
            title: String?,
            style: UIAlertAction.Style = .default,
            value: Action
        ) -> AlertAction {
            AlertAction(title: title, style: style, value: value)
        }
    }

    static func present<Action>(
        in viewController: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [AlertAction<Action>]
    ) -> Observable<Action> {
        return Observable.create { observer in
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: style
            )

            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(action.value)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }

            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
