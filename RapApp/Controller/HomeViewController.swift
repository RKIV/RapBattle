//
//  ViewController.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/16/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    
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
    
    @IBOutlet weak var progressBar: UIProgressView!
    var timer = Timer()
    var indexProgressBar = 500
    var poseDuration = 500
    
    @IBOutlet weak var musicBar: ScrubberBar!
    @IBOutlet weak var playButton: UIButton!
    var playState = 0

    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: Override Functions
    
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
        
        progressBar.barHeight = self.view.frame.height*0.05
        
        musicBar.barColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        musicBar.elapsedColor = UIColor(red:0.44, green:0.14, blue:0.13, alpha:1.0)
        musicBar.dragIndicatorColor = UIColor(red:0.10, green:0.10, blue:0.11, alpha:1.0)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SettingsViewController
        destination.delegate = self
        
        if let text = dataLabel?.text {
            destination.store = text
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        
        generateRandomWord()
        
        
    }
    
    func generateRandomWord(){
        
        // display the first pose
        timer.invalidate()
        progressBar.progress = 1.0
        indexProgressBar = 500
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
        
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

    
    //MARK: - Progress
    
    @objc func setProgressBar(){
        
        // update the display
        // use poseDuration - 1 so that you display 20 steps of the the progress bar, from 0...19
        progressBar.progress = Float(indexProgressBar) / Float(poseDuration + 1)
        
        // increment the counter
        indexProgressBar -= 1
        
        if indexProgressBar == 0 {
            generateRandomWord()
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        if playState == 0{
            playState = 1
            playButton.setImage(UIImage(named: "if_button_pause_red_14773")!, for: UIControlState.normal)
        } else {
            playState = 0
            playButton.setImage(UIImage(named: "if_button_play_red_14778")!, for: UIControlState.normal)
        }
        
    }
    
}

extension HomeViewController: SettingsDelegate {
    func sendData(input: String) {
        dataLabel.text = input
    }
    
    
}




