//
//  SignInViewController.swift
//  FirebaseLesson1
//
//  Created by Noishiki Tatsunori on 2020/02/14.
//  Copyright © 2020 Noishiki Tatsunori. All rights reserved.
//

import UIKit
import PGFramework


// MARK: - Property
class SignInViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func touchedSignInButton(_ sender: UIButton) {
        UserModel.signIn(email: emailTextField.text ?? "", pass: passwordTextField.text ?? "", failure: { (error) in
            print(error)
        }) {
            let vc = MypageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.animatorManager.navigationType = .slide_push
            print("成功")
        }
    }
    @IBAction func touchedSignUpButton(_ sender: UIButton) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
        animatorManager.navigationType = .slide_push
    }
    var userModel: UserModel = UserModel()
}

// MARK: - Life cycle
extension SignInViewController {
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Protocol
extension SignInViewController {
    
}

// MARK: - method
extension SignInViewController {
    
}

