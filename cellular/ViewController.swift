//
//  ViewController.swift
//  cellular
//
//  Created by miniMac on 3/6/19.
//  Copyright © 2019 Christopher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var help: UIButton!
    
    var bubbleSound: SystemSoundID!
    
    let defaultDurationStart = 3.0
    let defaultDampingStart = 0.3
    let defaultVelocityStart = 5.4
    
    let defaultDurationStop = 2.5
    let defaultDampingStop = 0.25
    let defaultVelocityStop = 5.4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bubbleSound = createBubbleSound()
        animateStartButton()
        animateStopButton()
    }
    
    // ⬇︎⬇︎⬇︎ animation happens here ⬇︎⬇︎⬇︎
    func animateStartButton() {
        AudioServicesPlaySystemSound(bubbleSound)
        startBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: defaultDurationStart,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(defaultDampingStart),
                       initialSpringVelocity: CGFloat(defaultVelocityStart),
                       options: .allowUserInteraction,
                       animations: {
                        self.startBtn.transform = .identity
        },
                       completion: { finished in
                        self.animateStartButton()
        }
        )
    }
    
    func animateStopButton() {
        AudioServicesPlaySystemSound(bubbleSound)
        stopBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: defaultDurationStop,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(defaultDampingStop),
                       initialSpringVelocity: CGFloat(defaultVelocityStop),
                       options: .allowUserInteraction,
                       animations: {
                        self.stopBtn.transform = .identity
        },
                       completion: { finished in
                        self.animateStopButton()
        }
        )
    }
    
    func createBubbleSound() -> SystemSoundID {
        var soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "bubble" as CFString!, "mp3" as CFString!, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        return soundID
    }
    
    @IBAction func stopBtnActioin(_ sender: Any) {
        
        let alert = UIAlertController(title: "Alert", message: "Stop Managing Data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func startBtnAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Alert", message: "Start Managing Data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
    }

    @IBAction func on_offBtnAction(_ sender: Any) {
    }
}

