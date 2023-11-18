//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    let eggTimes : [String : Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if let hardness = sender.currentTitle, let result = eggTimes[hardness] {
            progressBar.progress = 0.0
            totalTime = Int(result)
            secondsPassed = 0
            titleLabel.text = hardness
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                if secondsPassed < totalTime {
                    
                    secondsPassed += 1
                    
                    progressBar.progress = (Float(secondsPassed)/Float(totalTime))
                    print(Float(secondsPassed)/Float(totalTime))
                    
                    
                } else {
                    Timer.invalidate()
                    self.titleLabel.text = "Done!"
                    playSound(soundName: "alarm_sound")
                }
            }
        } else {
            print("Cooking time not found for the selected hardness level.")
        }
        
        
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}
