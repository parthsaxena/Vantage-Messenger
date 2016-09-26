//
//  ViewController.swift
//  Vantage Messenger
//
//  Created by Parth Saxena on 9/23/16.
//  Copyright © 2016 Socify. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var vMessageLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var setUpButton: UIButton!
    
    var effect: UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vMessageLabel.alpha = 0
        descriptionTextView.alpha = 0
        descriptionTextView.center.y = self.view.frame.height - 25
        setUpButton.isEnabled = false
        setUpButton.alpha = 0
        
        effect = blurEffect.effect
        //blurEffect.effect = nil
       // self.view.sendSubview(toBack: blurEffect)
    }

    override func viewDidAppear(_ animated: Bool) {
        setupAnimate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupAnimate() {
        self.view.bringSubview(toFront: blurEffect)
        self.view.bringSubview(toFront: vMessageLabel)
        
        vMessageLabel.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.vMessageLabel.alpha = 1
            }, completion: { (success: Bool) in
                self.view.bringSubview(toFront: self.setUpButton)
                UIView.animate(withDuration: 1, animations: {
                    self.descriptionTextView.alpha = 1
                    self.descriptionTextView.center.y = self.view.frame.height / 2
                    }, completion: { (success: Bool) in
                        UIView.animate(withDuration: 0.7, animations: {
                            self.setUpButton.isEnabled = true
                            self.setUpButton.alpha = 1
                        })
                })
        })
    }
}

