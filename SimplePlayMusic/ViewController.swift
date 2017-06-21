//
//  ViewController.swift
//  SimplePlayMusic
//
//  Created by hungtran on 6/20/17.
//  Copyright © 2017 hungtran. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var slder_volume: UISlider!
    @IBOutlet weak var lbl_timeLeft: UILabel!
    @IBOutlet weak var lbl_timeSong: UILabel!
    @IBOutlet weak var sld_Duration: UISlider!
    @IBOutlet weak var sw_replay: UISwitch!
    
    
    var audio = AVAudioPlayer()
    var count = 0
    var timer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try!AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "XO - The Eden Project [MP3 192kbps]",ofType: ".mp3")!) as URL)
        audio.prepareToPlay()
        addThumbImageForSlider()
        sld_Duration.setValue(0.00, animated: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        audio.delegate = self
    }
    
    func addThumbImageForSlider()
    {
        slder_volume.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        slder_volume.setThumbImage(UIImage(named: "thumbHightLight"), for: .highlighted)
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), for: .normal)
    }
    
    func updateTimeLeft() {
        let timeLeft = Int(audio.currentTime)
        let min = timeLeft / 60
        let sec = timeLeft - min * 60
        lbl_timeLeft.text = String(format: "%2d:%02d", min, sec)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
        let totalTime = Int(audio.duration)
        let minTotal = totalTime / 60
        let secTotal = totalTime - minTotal * 60
        lbl_timeSong.text = String(format: "%2d:%02d", minTotal, secTotal)
     }

    @IBAction func action_play(_ sender: Any) {
        if count == 0 {
            audio.play()
            btn_Play.setImage(UIImage(named: "pause.png"), for: .normal)
            count = 1
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        }else if count == 1{
            audio.pause()
            btn_Play.setImage(UIImage(named: "play.png"), for: .normal)
            count = 0
        }
    }

    @IBAction func action_replay(_ sender: Any) {
        replay()
    }
    
    
    
    @IBAction func sld_volume(_ sender: Any) {
        audio.volume = (sender as AnyObject).value
    }
    
    @IBAction func sld_timeSong(_ sender: UISlider) {
        audio.currentTime = TimeInterval(Float(sender.value) * Float(audio.duration))
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btn_Play.setImage(UIImage(named: "play.png"), for: .normal)
    }
    
    func replay() {
        if (sw_replay.isOn == true) {
            audio.numberOfLoops = -1
        }else{
            audio.numberOfLoops = 0
        }
    }
    

}

