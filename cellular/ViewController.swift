//
//  ViewController.swift
//  cellular
//
//  Created by miniMac on 3/6/19.
//  Copyright © 2019 Christopher. All rights reserved.
//

import UIKit
import AVFoundation
import SideMenu

class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var displayOnOff: UILabel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
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
        
        self.removeHighlightLabel(label: displayOnOff)
        
    }
    
    @IBAction func startBtnAction(_ sender: Any) {
        
        self.highlightLabel(label: displayOnOff)
        
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
    }
    
    // When focussed - show gray border
    func highlightLabel(label: UILabel){
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 4
        label.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
    // Label is NOT empty - show gray border with 0 border width
    func removeHighlightLabel(label: UILabel){
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 0
        label.layer.cornerRadius = 4
        label.layer.backgroundColor = UIColor.clear.cgColor
    }
    
}

extension ViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
}
