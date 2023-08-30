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

//    private func setupUI() {
//        signInBtn.isEnabled = false
//        emailTF.backgroundColor = UIColor.white // Add color to some walue
//    }
//}
///// продолжение нашего класса
///// в extension могут быть только методы
//extension SignInVC {}
    // отрабатывает единожды
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            /// в идеале в UserDafult нужно записать булевое значениe залогирован ли пользователь
            if let _ = UserDafultsService.getUserModel() {
                goToTabBarController()
            }
        }
        
        // этот метод вызывается перед каждым появлением этого экрана и стирает данные из него
        override func viewWillAppear(_ animated: Bool) {
            emailTF.text = ""
            passTF.text = ""
        }
        
    @IBAction func signInAction() {
            errorLbl.isHidden = true
            guard let email = emailTF.text,
                  let pass = passTF.text,
                  let userModel = UserDafultsService.getUserModel(),
                  email == userModel.email,
                  pass == userModel.pass
            else {
                errorLbl.isHidden = false
                return
            }
            
            goToTabBarController()
        }
        
        private func setupUI() {
    //        signInBtn.isEnabled = false
        }
        
        
        
        private func goToTabBarController() {
            let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    /// продолжение нашего класса
    /// в extension могут быть только методы
    extension SignInVC {
        
    }
