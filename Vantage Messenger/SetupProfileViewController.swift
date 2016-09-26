//
//  SetupProfileViewController.swift
//  Vantage Messenger
//
//  Created by Parth Saxena on 9/24/16.
//  Copyright © 2016 Socify. All rights reserved.
//

import UIKit

class SetupProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mainSetUpView: UIView!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var introLabel: UITextView!
    
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        introLabel.alpha = 0
        introLabel.center.y = self.view.frame.height
        mainSetUpView.alpha = 0
        self.view.sendSubview(toBack: mainSetUpView)
        
        profilePictureImageView.layer.masksToBounds = true
        profilePictureImageView.layer.cornerRadius = (profilePictureImageView.image?.size.width)! / 2
        
        phoneNumberLabel.delegate = self
        
        /*// set alphas of subview to zero
        profilePictureImageView.alpha = 0
        fullNameLabel.alpha = 0
        phoneNumberLabel.alpha = 0
        nextButton.alpha = 0*/
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 1.0, animations: { 
            self.introLabel.alpha = 1
            self.introLabel.center.y = self.view.frame.height / 2
        }) { (success: Bool) in
                UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                    self.introLabel.alpha = 0
                    self.introLabel.center.y = 0
                    }, completion: { (success: Bool) in
                            self.view.bringSubview(toFront: self.mainSetUpView)
                            UIView.animate(withDuration: 1.0, animations: { 
                                self.mainSetUpView.alpha = 1
                                }, completion: nil)
                })
        }
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        NSLog("starting delegate")
        if textField == phoneNumberLabel {
            let text = textField.text
            let characterCount = textField.text?.characters.count
            if (characterCount == 3) {
                // user has typed in area code
                NSLog("user typed in area code")
                let newString = "(\(text))-"
                replaceText(newText: newString)
            } else if (characterCount == 6) {
                let newString = "\(text)-"
                replaceText(newText: newString)
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneNumberLabel {
            let text = textField.text
            let characterCount = textField.text?.characters.count
            if (characterCount == 3) {
                // user has typed in area code
                NSLog("user typed in area code")
                let newString = "(\(text))-"
                replaceText(newText: newString)
            } else if (characterCount == 6) {
                let newString = "\(text)-"
                replaceText(newText: newString)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSLog("starting delegate")
        if textField == phoneNumberLabel {
            let text = textField.text
            NSLog(text!)
            let characterCount = textField.text?.characters.count
            if (characterCount == 3) {
                // user has typed in area code
                NSLog("user typed in area code")
                let newString = "(\(text!))-"
                replaceText(newText: newString)
            } else if (characterCount == 9) {
                let newString = "\(text!)-"
                replaceText(newText: newString)
            }
        }
        return true
    }
    
    func replaceText(newText: String) {
        phoneNumberLabel.text = newText
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
