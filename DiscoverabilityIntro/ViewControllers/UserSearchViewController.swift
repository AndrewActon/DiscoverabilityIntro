//
//  UserSearchViewController.swift
//  DiscoverabilityIntro
//
//  Created by Andrew Acton on 3/22/23.
//

import UIKit

class UserSearchViewController: UIViewController {

    
    @IBOutlet weak var userExistsLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        
        UserController.shared.checkForExistingUserWith(email: email) { user in
            var labelText = ""
            
            if let user = user {
                //The user exists as both discoverable and in the curent user's contacts list.
                
                labelText = "\(user.name) has the app and has authorized user discoverability (and is par of your contact list)."
            } else {
                //The user either didn't accept discoverability and/or they aren't in the current user's contact list.
                
                labelText = "User with email \(email) either didn't accept discoverability and/or they aren't in the current user's contact list."
            }
            
            DispatchQueue.main.async {
                self.userExistsLabel.text = labelText
            }
        }
    }

}//End Of Class
