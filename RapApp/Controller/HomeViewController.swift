//
//  ViewController.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/16/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import AVFoundation
import AudioKit

class HomeViewController: UIViewController {
    
    
    // MARK: Variables
    //Audio Player
    
    var audioPlayer: AVAudioPlayer!
    var words: [Word]?
    var tracker: AKAmplitudeTracker?
    var player: AKPlayer?
    
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
    var trackerTimer = Timer()
    var progressBarTimer = Timer()
    var indexProgressBar = 500
    var poseDuration = 500
    
    @IBOutlet weak var musicBar: ScrubberBar!
    @IBOutlet weak var playButton: UIButton!
    var playState = 0
    
    var musicSelected = "Beat1.mp3"

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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        
    }
    
    //MARK: Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        usedWordsCounter = []
        generateRandomWord()
        
        
    }
    
    func generateRandomWord(){
        
        // display the first pose
        progressBarTimer.invalidate()
        progressBar.progress = 1.0
        indexProgressBar = 500
        
        // start the timer
        progressBarTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(HomeViewController.setProgressBar), userInfo: nil, repeats: true)
        
        let randomWordGenerated = WordArray.randomWordArray[Int(arc4random_uniform(UInt32(WordArray.randomWordArray.count)))]
        
        DatamuseAPIService.getRhymingSet(for: randomWordGenerated) { (words) in
            DispatchQueue.main.async {
                self.randomWord.text = "Word: \(randomWordGenerated)"
                self.randomWord.adjustsFontSizeToFitWidth = true
                for (_, element) in self.rhymeWordsArray.enumerated() {
                    let index = self.generateRandomNumber(arrayCount: words.count)
                    element.adjustsFontSizeToFitWidth = true
                    if let _index = index {
                        element.text = words[_index].word
                        element.text = element.text?.capitalizingFirstLetter()
                    } else {
                        element.text = ""
                    }
                    
                    
//                    print(element.text ?? "")
                    
                }
            }
        }
        
    }
    
    func generateRandomNumber(arrayCount number:Int) -> Int?{
        print(usedWordsCounter.count, number)
        if usedWordsCounter.count == number{
            return nil
        }
        var numberNotFound = true
        var randomNumber = 0
        while(numberNotFound){
            numberNotFound = false
            randomNumber = Int(arc4random_uniform((UInt32(number))))
            for used in usedWordsCounter {
                if randomNumber == used{
                    numberNotFound = true
                    break
                }else{
                    continue
                }
            }
        }
        usedWordsCounter.append(randomNumber)
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
            usedWordsCounter = []
            generateRandomWord()
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        if playState == 0{
            playState = 1
            playButton.setImage(UIImage(named: "if_button_pause_red_14773")!, for: UIControlState.normal)
            assignSound(fileName: musicSelected)
            player?.play()
            
        } else {
            playState = 0
            playButton.setImage(UIImage(named: "if_button_play_red_14778")!, for: UIControlState.normal)
            player?.pause()
            
        }
        
    }
    
    @objc func trackerUpdate(){
        let fontSize = 34 * (1 + (tracker?.amplitude)!)
        randomWord.font = UIFont(name: randomWord.font.fontName, size: CGFloat(fontSize))
    }
    
    func assignSound(fileName: String){
        
        trackerTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(HomeViewController.trackerUpdate), userInfo: nil, repeats: true)
        
        do {
            let file = try AKAudioFile(readFileName: fileName)
            let player = AKPlayer(audioFile: file)
            player.isLooping = true
            
            let tracker = AKAmplitudeTracker(player)
            AudioKit.output = tracker
            self.player = player
            self.tracker = tracker
            try AudioKit.start()
            
        } catch let error {
            print("Sound failed:", error)
        }
        
    }
    
    
}







