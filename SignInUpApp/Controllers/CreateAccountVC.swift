//
//  CreateAccountVC.swift
//  SignInUpApp
//
//  Created by Kate on 26/08/2023.
//

import UIKit

class CreateAccountVC: UIViewController {
    // email
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var errorEmailLbl: UILabel!
    // name
    @IBOutlet var nameTF: UITextField!
    // password
    @IBOutlet var passwordTF: UITextField! {
        didSet {
            passwordTF.tintColor = UIColor.lightGray
            passwordTF.setIcon(UIImage(imageLiteralResourceName:"Image"))
        }
    }
    @IBOutlet var errorPassLbl: UILabel!
    // pass indicators
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    // confirm
    @IBOutlet var ConfPassTF: UITextField! {
        didSet {
            ConfPassTF.tintColor = UIColor.lightGray
            ConfPassTF.setIcon(UIImage(imageLiteralResourceName:"Image"))
        }
    }
    @IBOutlet var errorConfPassLbl: UILabel!
    // Continue button
    @IBOutlet var continueBtn: UIButton!
    // scrollView
    @IBOutlet var scrollView: UIScrollView!
    
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        // hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        // to check this action:
        // print(sender.text)
        if let email = sender.text,
           !email.isEmpty,
           // email verification
           VerificationService.isValidEmail(email: email)
        {
            isValidEmail = true
            // print(isValidEmail = true)
        } else {
            isValidEmail = false
        }
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty
        {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
            print(passwordStrength)
        } else {
            passwordStrength = .veryWeak
        }
        errorPassLbl.isHidden = passwordStrength != .veryWeak
    
        setupStrongIndicatorsViews()
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty
        {
            isConfPass = VerificationService.isPassConfirm(pass1: passText, pass2: confPassText)
        } else {
            isConfPass = false
        }
        errorConfPassLbl.isHidden = isConfPass
    }
    
    @IBAction func signInAction() {
//        navigationController?.popToRootViewController(animated: true) to the fisrst screen
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text
        {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "goToVerifScreen", sender: userModel)
        }
    }
    
    private func setupStrongIndicatorsViews() {
        /* как раскрасить вьюшки:
         for (index, view) in strongPassIndicatorsViews.enumerated() {
             if index <= (passwordStrength.rawValue - 1) {
                 view.alpha = 1
             } else {
                 view.alpha = 0.2
             }
         }
         */
        // тоже самое но через forEach
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
   
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
}
