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
    
    var rhymeWordsArray = [UILabel]()
    var usedWordsCounter = [Int]()
    
    
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
        
        for i in rhymeWordsArray{
            i.layer.masksToBounds = true
            i.layer.cornerRadius = 6
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        var randomWordGenerated = WordArray.randomWordArray[Int(arc4random_uniform(UInt32(WordArray.randomWordArray.count)))]
        
        DatamuseAPIService.getRhymingSet(for: randomWordGenerated) { (words) in
            DispatchQueue.main.async {
                self.randomWord.text = "Word: \(randomWordGenerated)"
                self.randomWord.adjustsFontSizeToFitWidth = true
                for (index, element) in self.rhymeWordsArray.enumerated() {
                    var x = self.generateRandomNumber(arrayCount: words.count)
                    element.text = words[x].word
                    element.adjustsFontSizeToFitWidth = true
                    element.text?.capitalizingFirstLetter()
                    
                    print(element.text)
                    
                }
            }
        }
        
    }
    
    func generateRandomNumber(arrayCount number:Int) -> Int{
        var randomNumber = arc4random_uniform((UInt32(number)))
        for used in usedWordsCounter {
            while randomNumber == used{
                randomNumber = arc4random_uniform((UInt32(number)))
            }
            if used != randomNumber{
                usedWordsCounter.append(Int(randomNumber))
            }
        }
        return Int(randomNumber)
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
