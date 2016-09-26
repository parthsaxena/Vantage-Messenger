//
//  LogInViewController.swift
//  Vantage Messenger
//
//  Created by Parth Saxena on 9/24/16.
//  Copyright © 2016 Socify. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var alreadyHaveAccountTextView: UITextView!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var dontHaveAccountTextView: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var oldHaveAccountYCoord: CGFloat!
    var oldDontHaveAccountYCoord: CGFloat!
    
    @IBOutlet var signUpView: UIView!
    @IBOutlet var logInView: UIView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect: UIVisualEffect!
    
    // sign up values
    @IBOutlet weak var signUpEmailField: UITextField!
    @IBOutlet weak var signUpPasswordField: UITextField!
    @IBOutlet weak var signUpViewButton: UIButton!
    
    // log in values
    @IBOutlet weak var logInEmailField: UITextField!
    @IBOutlet weak var logInPasswordField: UITextField!
    @IBOutlet weak var logInViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        self.view.sendSubview(toBack: visualEffectView)
        
        alreadyHaveAccountTextView.alpha = 0
        oldHaveAccountYCoord = alreadyHaveAccountTextView.center.y
        alreadyHaveAccountTextView.center.y = 0
        logInButton.alpha = 0
        logInButton.center.x = 0
        
        dontHaveAccountTextView.alpha = 0
        
        oldDontHaveAccountYCoord = dontHaveAccountTextView.center.y
        dontHaveAccountTextView.center.y = self.view.frame.height
        signUpButton.alpha = 0
        signUpButton.center.x = self.view.frame.width
        
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
            self.alreadyHaveAccountTextView.alpha = 1
            self.alreadyHaveAccountTextView.center.y = self.oldHaveAccountYCoord
            self.dontHaveAccountTextView.alpha = 1
            self.dontHaveAccountTextView.center.y = self.oldDontHaveAccountYCoord
        }) { (success: Bool) in
            UIView.animate(withDuration: 1, animations: { 
                self.logInButton.alpha = 1
                self.logInButton.center.x = self.view.frame.width / 2
                self.signUpButton.alpha = 1
                self.signUpButton.center.x = self.view.frame.width / 2
                }, completion: nil)
        }
    }
    
    @IBAction func logInTapped(_ sender: AnyObject) {
        animateLoginIn()
    }
    
    @IBAction func signUpTapped(_ sender: AnyObject) {
        animateSignupIn()
    }
    
    @IBAction func closeLogInTapped(_ sender: AnyObject) {
        animateLoginOut()
    }
    
    @IBAction func closeSignUpTapped(_ sender: AnyObject) {
        animateSignupOut()
    }
    
    func animateLoginIn() {
        self.view.addSubview(logInView)
        logInView.center = self.view.center
        
        logInView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        logInView.alpha = 0
        self.view.bringSubview(toFront: visualEffectView)
        self.view.bringSubview(toFront: logInView)
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.logInView.alpha = 1
            self.logInView.transform = CGAffineTransform.identity
        }
    }
    
    func animateLoginOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.logInView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.logInView.alpha = 0
            
            self.visualEffectView.effect = nil
            
        }) { (success: Bool) in
            self.logInView.removeFromSuperview()
            self.view.sendSubview(toBack: self.visualEffectView)
        }
    }
    
    func animateSignupIn() {
        self.view.addSubview(signUpView)
        signUpView.center = self.view.center
        
        signUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        signUpView.alpha = 0
        self.view.bringSubview(toFront:
            visualEffectView)
        self.view.bringSubview(toFront: signUpView)
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.signUpView.alpha = 1
            self.signUpView.transform = CGAffineTransform.identity
        }
    }
    
    func animateSignupOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.signUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.signUpView.alpha = 0
            
            self.visualEffectView.effect = nil
            
        }) { (success: Bool) in
            self.signUpView.removeFromSuperview()
            self.view.sendSubview(toBack: self.visualEffectView)
        }
    }

    @IBAction func viewLogInTapped(_ sender: AnyObject) {
        logInViewButton.setTitle("Loading...", for: UIControlState.normal)
        
        let username = logInEmailField.text
        let password = logInPasswordField.text
        
        FIRAuth.auth()?.signIn(withEmail: username!, password: password!, completion: { (user, error) in
            if error != nil {
                // error
                self.signUpViewButton.setTitle("Log In >", for: UIControlState.normal)
                let alert = UIAlertController(title: "Error", message: "There was an error logging you in.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alert.view.tintColor = UIColor.red
            } else {
                // success
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetUpProfileVC")
                self.present(vc!, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func viewSignUpTapped(_ sender: AnyObject) {
        signUpViewButton.setTitle("Loading...", for: UIControlState.normal)
        
        let username = signUpEmailField.text
        let password = signUpPasswordField.text
        
        FIRAuth.auth()?.createUser(withEmail: username!, password: password!, completion: { (user, error) in
            if error != nil {
                // error
                self.signUpViewButton.setTitle("Get Started >", for: UIControlState.normal)
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alert.view.tintColor = UIColor.red
                self.present(alert, animated: true, completion: nil)
            } else {
                // success
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetUpProfileVC")
                self.present(vc!, animated: true, completion: nil)
            }
        })
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //keyboardHeight = keyboardSize.height
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 150
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 150
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
