//
//  ViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/9/24.
//

import UIKit
import Then
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GetUserData.shared.getUserData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.updateProfile()
                    self?.updateFolloweButton()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func updateProfile(){
        if let avatarURL = URL(string: User.shared.avatarURL) {
            profileImageView.kf.setImage(with: avatarURL)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        let nameLabel = UILabel().then {
            $0.text = "\(User.shared.name ?? "")"
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textColor = .black
        }
        
        let emailLabel = UILabel().then {
            $0.text = "\(User.shared.login)"
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .black
        }
        
        let locationLabel = UILabel().then {
            $0.text = "\(User.shared.createdAt)"
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = .black
        }
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(locationLabel)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
    }
    
    func updateFolloweButton(){
        let followerButton = UIButton().then {
            $0.setTitle("Followers \(User.shared.followers)", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 10
        }
        let followingButton = UIButton().then {
            $0.setTitle("Following \(User.shared.following)", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 10
        }
        
        buttonStackView.addArrangedSubview(followerButton)
        buttonStackView.addArrangedSubview(followingButton)
        buttonStackView.spacing = 8
    }
    
}

