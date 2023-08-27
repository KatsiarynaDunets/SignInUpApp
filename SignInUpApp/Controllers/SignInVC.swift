//
//  SignInVC.swift
//  SignInUpApp
//
//  Created by Kate on 23/08/2023.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel! {
        didSet { errorLbl.isHidden = true }
           }
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        signInBtn.isEnabled = false
    }
}
/// продолжение нашего класса
/// в extension могут быть только методы
extension SignInVC {
}
