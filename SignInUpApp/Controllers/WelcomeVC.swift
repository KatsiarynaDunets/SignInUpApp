//
//  WelcomeVC.swift
//  SignInUpApp
//
//  Created by Kate on 28/08/2023.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet var infoLbl: UILabel!
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func continueAction() {
        guard let userModel = userModel else { return }
        UserDafultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }

    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our Sign App"
    }
}
