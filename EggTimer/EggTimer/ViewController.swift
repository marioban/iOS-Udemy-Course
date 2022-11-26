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
    
    let eggTimes = ["Soft":3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secPassed = 0
    var timer = Timer()
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?

    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secPassed = 0
        statusLabel.text = hardness
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
        sender.layer.opacity = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){sender.layer.opacity=1}
    }
    
    
    @objc func updateCounter() {
        //example functionality
        if secPassed <= totalTime {
            statusLabel.text = secPassed.description
            
            let percentageProgress = Float(secPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            
            
            secPassed += 1
        }else {
            playSound()
            statusLabel.text = "Done"
        }
    }
    
   
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
