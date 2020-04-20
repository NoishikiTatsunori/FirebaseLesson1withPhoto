//
//  SignUpViewController.swift
//  FirebaseLesson1
//
//  Created by Noishiki Tatsunori on 2020/02/14.
//  Copyright © 2020 Noishiki Tatsunori. All rights reserved.
//

import UIKit
import PGFramework
import FirebaseAuth


// MARK: - Property
class SignUpViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBAction func touchedSignUpButton(_ sender: UIButton) {
        userModel.mail = emailTextField.text
        userModel.password = passTextField.text
        UserModel.create(request: userModel, success: {
            let vc = MypageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.animatorManager.navigationType = .slide_push
        }) { (error) in
            print(error)
            self.alert(message: error)
//            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passTextField.text!) { (user, error) in
//                if error == nil {
//                    // do something
//                } else {
//                    if let errCode = AuthErrorCode(rawValue: error!._code) {
//                        switch errCode {
//                        case .invalidEmail:
//                            self.showAlert("メールアドレスの形式が違います。")
//                        case .emailAlreadyInUse:
//                            self.showAlert("このメールアドレスは既に使われています。")
//                        case .weakPassword:
//                            self.showAlert("パスワードは6文字以上で入力してください。")
//                        default:
//                            self.showAlert("エラーが起きました。しばらくしてから再度お試しください。")
//                        }
//                    }
//                }
//            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func touchedSignInButton(_ sender: UIButton) {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
        animatorManager.navigationType = .slide_push
    }
    var userModel: UserModel = UserModel()
}

// MARK: - Life cycle
extension SignUpViewController {
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
extension SignUpViewController {
    
}

// MARK: - method
extension SignUpViewController {
//    func showAlert(_ message: String) {
//        let alertController = UIAlertController(title: "新規登録に失敗しました", message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
}

