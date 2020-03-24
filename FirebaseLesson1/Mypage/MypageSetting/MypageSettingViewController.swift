//
//  MypageSettingViewController.swift
//  FirebaseLesson1
//
//  Created by Noishiki Tatsunori on 2020/02/14.
//  Copyright © 2020 Noishiki Tatsunori. All rights reserved.
//

import UIKit
import PGFramework


// MARK: - Property
class MypageSettingViewController: BaseViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBAction func touchedChangeIconButton(_ sender: UIButton) {
        if iconImageView.image == UIImage(named: "no_icon") {
            useCamera()
        } else {
            useCamera(isDeletable: true) { (action) in
                self.iconImageView.image = UIImage(named: "no_icon")
            }
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBAction func touchedDaneButton(_ sender: UIButton) {
        UserModel.update(request: myself, image: self.iconImageView.image) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func touchdedLogOutButton(_ sender: UIButton) {
        UserModel.logOut {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func touchedDeleteButton(_ sender: UIButton) {
        UserModel.delete {
            self.dismiss(animated: true, completion: nil)
        }
    }
    var myself: UserModel = UserModel()
}

// MARK: - Life cycle
extension MypageSettingViewController {
    override func loadView() {
        super.loadView()
        setTextField()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.iconImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Protocol
extension MypageSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            myself.mail = textField.text
        case 1:
            myself.password = textField.text
        default:
            break
        }
        return true
    }
}

// MARK: - method
extension MypageSettingViewController {
    func setTextField() {
        emailTextField.delegate = self
        passTextField.delegate = self
        emailTextField.text = myself.mail
        passTextField.text = myself.password
        if let url = URL(string: self.myself.photo_path ?? "") {
            self.iconImageView.af_setImage(withURL: url)
        } else {
            self.iconImageView.image = UIImage(named: "no_icon")
        }
    }
}

