//
//  ViewController.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/16/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import YLProgressBar

class ViewController: UIViewController {
    
    
    // MARK: Variables
    
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
    
    let progressBar = YLProgressBar()
    
    var timerCount = 10.0
    
    
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
        
        
        
        //Progress Bar Functionality
        progressBar.type = YLProgressBarType.flat
        progressBar.progressTintColor = UIColor.blue
        progressBar.trackTintColor = UIColor.white
        progressBar.hideStripes = true
        progressBar.setProgress(1, animated: false)
        progressBar.frame = CGRect(x: self.view.frame.width*0, y: self.view.frame.height*0.2, width: self.view.frame.width*1.0, height: self.view.frame.height*0.1)
        self.view.addSubview(progressBar)
    
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        
        //Timer Properties
//        var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)

        //Generate Random Word
        let randomWordNumber = arc4random_uniform(10)
        randomWord.text = String(randomWordNumber)
        
        //Generate Rhyme Words
        for word in rhymeWordsArray {
            let randomNumber = arc4random_uniform(10)
            word.text = String(randomNumber)
            print(randomNumber)
        }
        
        var counter = 10.0
        var _ = Timer(timeInterval: 0.01, repeats: counter > 0) { (_) in
            self.progressBar.progress = CGFloat(counter/10)
            counter = counter - 0.01
        }

        
    }
    
    
    
    //Progress Bar Count Down
//    @objc func update() {
//        progressBar.setProgress(CGFloat(timerCount/10), animated: false)
//        if(timerCount > 0) {
//            timerCount = timerCount - 0.1
//            print("Count:\(timerCount)")
//        } else {
//            timerCount = 10
//        }
//    }
    
}

