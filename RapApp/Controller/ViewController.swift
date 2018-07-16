//
//  ViewController.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/16/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    // MARK: Variables
    //Audio Player
    var audioPlayer: AVAudioPlayer!
    var words: [Word]?
    
    //Outlet Variables
    @IBOutlet weak var randomWord: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    
    
    //Order goes from left to right 1...4 then top to bottom 5...8
    @IBOutlet weak var rhymeOne: UILabel!
    @IBOutlet weak var rhymeTwo: UILabel!
    @IBOutlet weak var rhymeThree: UILabel!
    @IBOutlet weak var rhymeFour: UILabel!
    @IBOutlet weak var rhymeFive: UILabel!
    @IBOutlet weak var rhymeSix: UILabel!
    @IBOutlet weak var rhymeSeven: UILabel!
    @IBOutlet weak var rhymeEight: UILabel!
    @IBOutlet weak var rhymeNine: UILabel!
    @IBOutlet weak var rhymeTen: UILabel!
    @IBOutlet weak var rhymeEleven: UILabel!
    @IBOutlet weak var rhymeTwelve: UILabel!
    @IBOutlet weak var rhymeThirteen: UILabel!
    @IBOutlet weak var rhymeFourteen: UILabel!
    @IBOutlet weak var rhymeFifteen: UILabel!
    @IBOutlet weak var rhymeSixteen: UILabel!
    
    var rhymeWordsArray = [UILabel]()
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        rhymeWordsArray.append(rhymeOne)
        rhymeWordsArray.append(rhymeTwo)
        rhymeWordsArray.append(rhymeThree)
        rhymeWordsArray.append(rhymeFour)
        rhymeWordsArray.append(rhymeFive)
        rhymeWordsArray.append(rhymeSix)
        rhymeWordsArray.append(rhymeSeven)
        rhymeWordsArray.append(rhymeEight)
        rhymeWordsArray.append(rhymeNine)
        rhymeWordsArray.append(rhymeTen)
        rhymeWordsArray.append(rhymeEleven)
        rhymeWordsArray.append(rhymeTwelve)
        rhymeWordsArray.append(rhymeThirteen)
        rhymeWordsArray.append(rhymeFourteen)
        rhymeWordsArray.append(rhymeFifteen)
        rhymeWordsArray.append(rhymeSixteen)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        print("Generate Button Tapped")
        DatamuseAPIService.getRhymingSet(for: "word") { (words) in
            DispatchQueue.main.async {
                for (index, element) in self.rhymeWordsArray.enumerated() {
                    element.text = words[index].word
                }
            }
        }
    }
    
}

extension ViewController: AVAudioPlayerDelegate{
    
    // playing sound on tap of this button
    func playSong(withName song: String, andExtension fileExtension: String){
        // setting up url for your soundtrack
        let soundURL = Bundle.main.url(forResource: song, withExtension: fileExtension)
        
        
        
        do {
            // setting up audio player to play your sound
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch let error{
            // in case any errors occur
            print(error)
        }
        
        // playing your audio file
        audioPlayer.play()
    }
}
