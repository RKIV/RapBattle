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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var rapNote: rapNote
    
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
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "cancel":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    
}
