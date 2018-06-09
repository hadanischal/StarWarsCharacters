//
//  ViewController.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/8/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.methodService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func methodService() {
        let service : CharactersRouter! = CharactersRouter()
        service.fetchConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    print(converter)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    break
                }
            }
        }
    }
}

