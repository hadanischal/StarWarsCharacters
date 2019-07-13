//
//  Wireframe.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

protocol Wireframe {
    func presentAlert(_ controller: UIViewController, title: String, message: String)
}

class DefaultWireframe: Wireframe {
    func presentAlert(_ controller: UIViewController, title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
        })
        controller.present(alertView, animated: true, completion: nil)
    }
}
