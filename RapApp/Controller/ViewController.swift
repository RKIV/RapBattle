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
        
        var progressBar = YLProgressBar()
        progressBar.type = YLProgressBarType.flat
        progressBar.progressTintColor = UIColor.blue
        progressBar.hideStripes = true
        progressBar.progress = 1
        progressBar.frame = CGRect(x: self.view.frame.width*0, y: self.view.frame.height*0.2, width: self.view.frame.width, height: self.view.frame.height*0.1)
        self.view.addSubview(progressBar)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Generate Random Button Function
    @IBAction func randomButtonTapped(_ sender: Any) {
        print("Generate Button Tapped")
        let randomWordNumber = arc4random_uniform(10)
        randomWord.text = String(randomWordNumber)
        for word in rhymeWordsArray {
            let randomNumber = arc4random_uniform(10)
            word.text = String(randomNumber)
            print(randomNumber)
        }
    }
//    progressBar.progress = progressBar.progress - 0.1
    
}

