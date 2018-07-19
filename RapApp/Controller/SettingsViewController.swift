//
//  SettingsPage.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/17/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

import UIKit

class SettingsViewController: UIViewController{
    
    
    @IBOutlet weak var musicTableView: UITableView!
    
    @IBOutlet weak var musicLabel: UILabel!
    
    var store: String?
    
    var musicArray = ["Beat1.mp3","Beat2.mp3","Beat3.mp3", "Beat4.mp3", "Beat5.mp3", "Beat6.mp3",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicTableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HomeViewController
        let index = musicTableView.indexPathForSelectedRow?.row
        if destination.musicSelected == musicArray[index!]{
            destination.isStarted = true
        } else {
            destination.player?.stop()
            destination.isStarted = false
            destination.musicSelected = musicArray[index!]
            destination.musicNameButton.setTitle(destination.musicSelected, for: .normal)
        }
        destination.assignSound(fileName: destination.musicSelected)
        
    }
    
}

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicSelectionCell
        print("Cell1: \(cell)")
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func configureCell(cell: MusicSelectionCell, forIndexPath indexPath: IndexPath){
        
        cell.musicLabel.text = musicArray[indexPath.row]
    }
    
}



