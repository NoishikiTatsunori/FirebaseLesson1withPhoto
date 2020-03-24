//
//  MypageViewController.swift
//  FirebaseLesson1
//
//  Created by Noishiki Tatsunori on 2020/02/14.
//  Copyright © 2020 Noishiki Tatsunori. All rights reserved.
//

import UIKit
import PGFramework
import FirebaseAuth


// MARK: - Property
class MypageViewController: BaseViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    @IBAction func touchedEditButton(_ sender: UIButton) {
        let vc = MypageSettingViewController()
        vc.myself = self.myself
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    var myself: UserModel = UserModel()
}

// MARK: - Life cycle
extension MypageViewController {
    override func loadView() {
        super.loadView()
        UserModel.readMe { (myself) in
            self.myself = myself
            self.emailLabel.text = myself.mail
            self.passLabel.text = myself.password
            if let url = URL(string: myself.photo_path ?? "") {
                self.iconImageView.af_setImage(withURL: url)
            } else {
                self.iconImageView.image = UIImage(named: "no_icon")
            }
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser?.uid == nil {
            let vc = SignUpViewController()
            navigationController?.pushViewController(vc, animated: false)
            animatorManager.navigationType = .slide_push
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
extension MypageViewController {
    
}

// MARK: - method
extension MypageViewController {
    
}

