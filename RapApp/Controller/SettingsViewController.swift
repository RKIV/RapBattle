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
    
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var musicTableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var musicLabel: UILabel!
    
    var store: String?
    
    var musicArray = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let store = store {
            textField.text = store
        }
        
        musicTableView.dataSource = self
        
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: ni)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HomeViewController
        let index = musicTableView.indexPathForSelectedRow?.row
        destination.dataLabel.text = musicArray[index!]
    }
    
}

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView:UITableView!, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicSelectionCell
        print("Cell1: \(cell)")
        return cell
    }
    
    func configure(cell: MusicSelectionCell, atIndexPath indexPath: IndexPath) {
        //        let user = users[indexPath.row]
        //
        //        cell.usernameLabel.text = user.username
        //        cell.followButton.isSelected = user.isFollowed
    }
    
}



