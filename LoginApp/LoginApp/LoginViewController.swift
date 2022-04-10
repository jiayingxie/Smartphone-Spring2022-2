//
//  ViewController.swift
//  LoginApp
//
//  Created by Jiaying Xie on 3/27/22.
//

import UIKit
import Firebase
// pwd: 123456
class LoginViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 一开始的时候我不想让status显示
        lblStatus.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keychain = KeychainService().keyChain
        if keychain.get("uid") != nil {
            performSegue(withIdentifier: "segueDashboard", sender: self)
        }
    }
    
    func addKeychainAfterLogin(uid : String) {
        let keyChain = KeychainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }


    @IBAction func loginAction(_ sender: Any) {
        guard let email = txtEmail.text else {return}
        guard let password = txtPassword.text else {return}
        
        if email == "" || password == "" {
            lblStatus.text = "Please enter email and password"
            lblStatus.isHidden = false
            return
        }

        if email.isEmail == false {
            lblStatus.text = "Please enter valid email"
            lblStatus.isHidden = false
            return
        }
        
//        if password.isPasswordValid == false {
//            lblStatus.text = "Please enter strong password"
//            lblStatus.isHidden = false
//            return
//        }
        
        // 这个大框架是firebase提供的
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            // 下面这些code是我们自己写的
            if (error != nil) {
                strongSelf.lblStatus.text = error?.localizedDescription
                strongSelf.lblStatus.isHidden = false
                return
            }
            
            // if we are here, we are successfully logged in
//            txtEmail.text = ""
            strongSelf.txtPassword.text = ""
            strongSelf.addKeychainAfterLogin(uid: Auth.auth().currentUser!.uid)
            strongSelf.performSegue(withIdentifier: "segueDashboard", sender: strongSelf)
        }
        
    }
}

