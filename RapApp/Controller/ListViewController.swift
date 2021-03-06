//
//  ListViewController.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/19/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{
    
    @IBOutlet weak var rapListTableView: UITableView!
    
    var rapNotes = [RapNote]() {
        didSet {
            rapListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rapListTableView.dataSource = self
        
        rapNotes = CoreDataHelper.retrieveRapNotes()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rapListTableView.reloadData()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "displayNote":
            guard let indexPath = rapListTableView.indexPathForSelectedRow else {return}
            let rapNote = rapNotes[indexPath.row]
            let destination = segue.destination as! HomeViewController
            destination.rapNote = rapNote
            destination.rapNameTextField.text = rapNote.title
            destination.rapEditorTextView.text = rapNote.content
        case "addNote":
            print("create note bar button item tapped")
            let destination = segue.destination as! HomeViewController
            destination.rapNote = nil
            destination.rapEditorTextView.text = ""
            destination.rapNameTextField.text = ""
            
        default:
            print("unexpected segue identifer")
        }
    }
    
    
    
}

extension ListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return rapNotes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rapCell", for: indexPath) as! RapNoteCell
        configureCell(cell: cell, forIndexPath: indexPath)
        let note = rapNotes[indexPath.row]
        cell.rapNameLabel.text = note.title
        return cell
        
        
    }
    
    func configureCell(cell: RapNoteCell, forIndexPath indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt IndexPath: IndexPath) {
        
        if editingStyle == .delete {
            let noteToDelete = rapNotes[IndexPath.row]
            CoreDataHelper.delete(rapNote: noteToDelete)
            
            rapNotes = CoreDataHelper.retrieveRapNotes()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
    }
    
}
