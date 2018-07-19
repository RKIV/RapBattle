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
    
    @IBAction func unwindWithSegueToList(_ segue: UIStoryboardSegue){
        rapNotes = CoreDataHelper.retrieveRapNotes()
    }
    
}

extension ListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 3
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
    
}
