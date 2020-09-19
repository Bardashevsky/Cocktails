//
//  UIViewController + Extensions.swift
//  Cocktails
//
//  Created by Oleksandr Bardashevskyi on 12.09.2020.
//  Copyright © 2020 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String, complition: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            complition()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.modalPresentationStyle = .fullScreen
        alertController.addAction(cancelAction)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
