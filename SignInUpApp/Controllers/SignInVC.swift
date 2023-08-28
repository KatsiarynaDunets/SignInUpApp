//
//  SignInVC.swift
//  SignInUpApp
//
//  Created by Kate on 23/08/2023.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passTF: UITextField! {
        didSet {
            passTF.tintColor = UIColor.lightGray
            passTF.setIcon(UIImage(imageLiteralResourceName:"Image"))
        }
    }
    @IBOutlet var errorLbl: UILabel! {
        didSet { errorLbl.isHidden = true }
    }

    @IBOutlet var signInBtn: UIButton!

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
extension SignInVC {}
