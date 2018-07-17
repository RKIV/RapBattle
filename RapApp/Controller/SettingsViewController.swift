//
//  SettingsPage.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/17/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

import UIKit

protocol SettingsDelegate: class {
    func sendData(input: String)
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsDelegate?
    
    @IBOutlet weak var homeButton: UIButton!
    
    var store: String?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        delegate?.sendData(input: textField.text!)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let store = store {
            textField.text = store
        }
    }
    

    
}
