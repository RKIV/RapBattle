//
//  AVAudio.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/17/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import AVFoundation

extension HomeViewController: AVAudioPlayerDelegate{
    
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
