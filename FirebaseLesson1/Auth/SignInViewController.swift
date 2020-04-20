//
//  SignInViewController.swift
//  FirebaseLesson1
//
//  Created by Noishiki Tatsunori on 2020/02/14.
//  Copyright © 2020 Noishiki Tatsunori. All rights reserved.
//

import UIKit
import PGFramework
import FirebaseAuth

// MARK: - Property
class SignInViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func touchedSignInButton(_ sender: UIButton) {
        UserModel.signIn(email: emailTextField.text ?? "", pass: passwordTextField.text ?? "", failure: { (error) in
            print(error)
            self.alert(message: error)
//            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
//                if error == nil {
//                    // do something
//                } else {
//                    if let errCode = AuthErrorCode(rawValue: error!._code) {
//                        switch errCode {
//                        case .invalidEmail:
//                            self.showAlert("メールアドレスか見つかりません。")
//                        case .wrongPassword:
//                            self.showAlert("メールアドレスとパスワードの組み合わせが一致しません。")
//                        default:
//                            self.showAlert("エラーが起きました。しばらくしてから再度お試しください。")
//                        }
//                    }
//                }
//            }
        }) {
            let vc = MypageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.animatorManager.navigationType = .slide_push
            print("成功")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
//    func showAlert(_ message: String) {
//        let alertController = UIAlertController(title: "ログインに失敗しました", message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
}

