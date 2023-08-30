//
//  ProfileVC.swift
//  SignInUpApp
//
//  Created by Kate on 30/08/2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    var currentUser: UserModel?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadUserData()
        }
        
        func loadUserData() {
            if let user = UserDafultsService.getUserModel() {
                currentUser = user
                userNameLbl.text = user.name
                emailLbl.text = user.email
            }
        }
    
    
    @IBAction func deleteAccountAction() {
    UserDafultsService.cleanUserDefauts() //delete user data in DB
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true) //return to sign in screen
    }
}
    







/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
