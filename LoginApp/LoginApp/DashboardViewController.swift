//
//  DashboardViewController.swift
//  LoginApp
//
//  Created by Jiaying Xie on 3/27/22.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popViewController(animated: true)
        } catch let signoutError as NSError {
            print(signoutError.localizedDescription)
            return
        }
    }
    
}
