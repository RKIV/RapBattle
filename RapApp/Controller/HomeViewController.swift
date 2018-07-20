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
import Foundation

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
    
    var rhymeWordsArray = [UILabel]()
    var usedWordsCounter = [Int]()
    
    @IBOutlet weak var progressBar: UIProgressView!
    var trackerTimer = Timer()
    var progressBarTimer = Timer()
    var indexProgressBar = 2000
    var poseDuration = 2000
    
    @IBOutlet weak var rapModeSwitch: UISwitch!
    @IBOutlet weak var rapEditorTextView: UITextView!
    
    
    @IBOutlet weak var musicBar: ScrubberBar!
    @IBOutlet weak var playButton: UIButton!
    var playState = 0
    
    var isStarted = false
    var musicSelected = UserDefaults.standard.string(forKey: "currentMusic") ?? "Beat1.mp3"
    
    @IBOutlet  weak var scrubberBar: ScrubberBar!
    
    @IBOutlet weak var musicNameButton: UIButton!
    
    var rapNote: RapNote?
    
    @IBOutlet weak var rapNameTextField: UITextField!
    
    
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
        
        
        randomButton.layer.cornerRadius = 6
        
        rapModeSwitch.setOn(false, animated: false)
        
        progressBar.barHeight = self.view.frame.height*0.05
        
        musicBar.barColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        musicBar.elapsedColor = UIColor(red:0.44, green:0.14, blue:0.13, alpha:1.0)
        musicBar.dragIndicatorColor = UIColor(red:0.10, green:0.10, blue:0.11, alpha:1.0)
        musicBar.setProgress(progress: 0.5)
        
        musicBar.addTouchHandlers()
        
        musicNameButton.setTitle(musicSelected, for: .normal)
        
        musicBar.delegate = self
        
        playButton.setTitle("Play", for: .normal)
        playButton.setTitle("Pause", for: .selected)
        playButton.layer.cornerRadius = 6
        
        
        UIApplication.shared.isIdleTimerDisabled = true
        rapEditorTextView.isUserInteractionEnabled = false
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
        randomWord.isHidden = false
        rapNameTextField.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindWithSegueToHome(_ segue: UIStoryboardSegue){
        
    }
    
    //MARK: Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        
        
        //        appDelegate.orientationLock = .portraitUpsideDown
        //        let value = UIInterfaceOrientationMask.portraitUpsideDown
        //        UIDevice.current.setValue(value, forKey: "orientation")
        
        //        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portraitUpsideDown, andRotateTo: UIInterfaceOrientation.portraitUpsideDown)
        
        
        if rapModeSwitch.isOn {
            
            if rapEditorTextView.text != nil && rapEditorTextView.text != ""{
                saveNotes()}
            performSegue(withIdentifier: "notesList", sender: nil)
            
            
        } else {
            
            generateRandomWords()
            
        }
    }
    
    func generateRandomWords(){
        
        // display the first pose
        progressBar.progress = 1.0
        indexProgressBar = 2000
        // start the timer
        
        let randomWordGenerated = WordArray.randomWordArray[Int(arc4random_uniform(UInt32(WordArray.randomWordArray.count)))]
        
        DatamuseAPIService.getRhymingSet(for: randomWordGenerated) { (words) in
            DispatchQueue.main.async {
                //Setting the random word label
                self.randomWord.text = randomWordGenerated
                self.randomWord.adjustsFontSizeToFitWidth = true
                var usedIndeces: [Int] = []
                for (_, element) in self.rhymeWordsArray.enumerated() {
                    let index = self.generateRandomRhymeWord(arrayCount: words, used: usedIndeces)
                    element.adjustsFontSizeToFitWidth = true
                    if let index = index{
                        element.text = words[index].word
                        //                        print(words[index].frequency)
                        element.text = element.text?.capitalizingFirstLetter()
                        usedIndeces.append(index)
                    } else{
                        element.text = ""
                    }
                }
            }
        }
    }
    
    func generateRandomRhymeWord(arrayCount array: [Word], used: [Int]) -> Int?{
        if used.count == array.count{
            return nil
        }
        var chanceArray: [Double] = []
        var total: Double = 0
        var indexLocation: Int = 0
        for (index, word) in array.enumerated(){
            if used.contains(index){
                chanceArray.append(total)
                continue
            }
            chanceArray.append(total)
            total += pow(word.frequency!, 2)
        }
        var whileFail = 0
        while(true){
            if whileFail > 150{
                return nil
            }
            whileFail += 1
            let randomNumber = total * Double(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
            
            for (index, element) in chanceArray.enumerated(){
                if randomNumber > element{
                    indexLocation = index
                } else {
                    break
                }
            }
            if used.contains(indexLocation){
                continue
            } else{
                break
            }
        }
        
        return indexLocation
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
            generateRandomWords()
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        
        testPlayButton()
        
    }
    
    func testPlayButton() {
        if playState == 0{
            playState = 1
            playButton.isSelected = true
            assignSound(fileName: musicSelected)
            progressBarTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(HomeViewController.setProgressBar), userInfo: nil, repeats: true)
        } else {
            playState = 0
            playButton.isSelected = false
            player?.pause()
            progressBarTimer.invalidate()
        }
    }
    
    @objc func trackerUpdate(){
        let fontSize = 40 * (1 + (tracker?.amplitude)!)
        randomWord.font = UIFont(name: randomWord.font.fontName, size: CGFloat(fontSize))
    }
    
    func assignSound(fileName: String){
        
        trackerTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(HomeViewController.trackerUpdate), userInfo: nil, repeats: true)
        
        do {
            if isStarted == true {
                player?.resume()
                print("resume")
            } else {
                
                
                let file = try AKAudioFile(readFileName: fileName)
                let player = AKPlayer(audioFile: file)
                player.isLooping = true
                
                UserDefaults.standard.set(musicSelected, forKey: "currentMusic")
                UserDefaults.standard.synchronize()
                
                let tracker = AKAmplitudeTracker(player)
                AudioKit.output = tracker
                self.player = player
                self.tracker = tracker
                try AudioKit.start()
                
                player.play()
                isStarted = true
                print("Play")
                
            }
            
            
        } catch let error {
            print("Sound failed:", error)
        }
        
    }
    
    //Rap Mode
    
    @IBAction func rapModeToggled(_ sender: Any) {
        
        if rapModeSwitch.isOn{
            randomButton.setTitle("My Raps", for: .normal)
            rapEditorTextView.isUserInteractionEnabled = true
            randomWord.isHidden = true
            rapNameTextField.isHidden = false
            for x in rhymeWordsArray {
                x.text = ""
            }
        } else {
            randomButton.setTitle("Generate Rhymes", for: .normal)
            rapEditorTextView.isUserInteractionEnabled = false
            usedWordsCounter = []
            randomWord.isHidden = false
            rapNameTextField.isHidden = true
            if rapEditorTextView.text != nil && rapEditorTextView.text != ""{
                saveNotes()}
            rapNameTextField.text = ""
            rapEditorTextView.text = ""
            generateRandomWords()
        }
        
    }
    
    func saveNotes(){
        
        if rapNote != nil {
            
            if rapNameTextField.text != ""{
                rapNote?.title = rapNameTextField.text ?? "My Rap"
            } else {
                rapNote?.title = "My Rap"
            }
            
            rapNote?.content = rapEditorTextView.text ?? ""
            
            CoreDataHelper.saveRapNote()
        } else {
            
            let rapNote = CoreDataHelper.newRapNote()
            if rapNameTextField.text != ""{
                rapNote.title = rapNameTextField.text ?? "My Rap"
            } else {
                rapNote.title = "My Rap"
            }
            rapNote.content = rapEditorTextView.text ?? ""
            
            CoreDataHelper.saveRapNote()

            
        }
        
                

    }
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}


extension HomeViewController: ScrubberBarDelegate{
    
    func scrubberBar(bar: ScrubberBar, didScrubToProgress: Float) {
        
    }
    
    func didScrub() {
        player?.rate = Double(scrubberBar.elapsedBar.frame.maxX/self.view.frame.width)+0.5
    }
    
    
}







