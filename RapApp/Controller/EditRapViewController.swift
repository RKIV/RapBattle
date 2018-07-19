//
//  EditRapViewController.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/19/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class EditRapViewController: UIViewController {
    
    @IBOutlet weak var editRapTextField: UITextField!
    @IBOutlet weak var editRapTextView: UITextView!
    
    var rapNote: RapNote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let rapNote = rapNote {
            editRapTextField.text = rapNote.title
            editRapTextView.text = rapNote.content
        } else {
            editRapTextField.text = ""
            editRapTextView.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save" where rapNote != nil:
            rapNote?.title = editRapTextField.text ?? ""
            rapNote?.content = editRapTextView.text ?? ""
            
            CoreDataHelper.saveRapNote()
            
        case "save" where rapNote == nil:
            let rapNote = CoreDataHelper.newRapNote()
            rapNote.title = editRapTextField.text ?? ""
            rapNote.content = editRapTextView.text ?? ""
            
            CoreDataHelper.saveRapNote()
            
        case "cancel":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    
}
