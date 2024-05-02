//
//  ViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/9/24.
//

import UIKit
import Then
import Kingfisher
import MarkdownView
import SnapKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    let mdView = MarkdownView()
    
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
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        updateMarkdownView()
    }
    
    func updateProfile(){
        if let avatarURL = URL(string: User.shared.avatarURL) {
            profileImageView.kf.setImage(with: avatarURL)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        let nameLabel = UILabel().then {
            $0.text = "\(User.shared.name ?? "")"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .black
        }
        
        let emailLabel = UILabel().then {
            $0.text = "\(User.shared.login)"
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textColor = .black
        }
        
        let locationLabel = UILabel().then {
            $0.text = User.shared.createdAt.convertToCustomFormat()
            $0.font = UIFont.systemFont(ofSize: 17)
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
    
    func updateMarkdownView(){
        loadData()
        scrollView.addSubview(mdView)
        
        mdView.snp.makeConstraints{
            $0.top.equalTo(menuTableView.snp.bottom)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }

        mdView.isScrollEnabled = true
    }
    
    func loadData() {
        GetUserData.shared.getUserMd { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let readmeResponse):
                getReadMe( urlString: readmeResponse.downloadUrl )
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getReadMe( urlString: String ){
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let markdownString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self?.mdView.load(markdown: markdownString)
                }
            }
        }
        task.resume()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableCell", for: indexPath) as? MenuTableCell else {
            return UITableViewCell()
        }
        
        let iconImage = ["repo", "file-code", "organization"]
        let menuName = ["Repo", "Event", "Organization"]
        cell.configure(with: (image: UIImage(named: iconImage[indexPath.row]), title: menuName[indexPath.row], symbolName: "chevron.right"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // 원하는 높이 값으로 변경
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Repo", bundle: nil)
            if let pushVC = storyboard.instantiateViewController(withIdentifier: "Repo") as? RepoViewController {
                self.navigationController?.pushViewController(pushVC, animated: true)
                print("success")
            } else {
                print("error")
            }
        case 1:
            let storyboard = UIStoryboard(name: "Event", bundle: nil)
            if let pushVC = storyboard.instantiateViewController(withIdentifier: "Event") as? EventViewController {
                self.navigationController?.pushViewController(pushVC, animated: true)
                print("success")
            } else {
                print("error")
            }
        case 2:
            let storyboard = UIStoryboard(name: "Organization", bundle: nil)
            if let pushVC = storyboard.instantiateViewController(withIdentifier: "Organization") as? OrganizationViewController {
                self.navigationController?.pushViewController(pushVC, animated: true)
                print("success")
            } else {
                print("error")
            }
        default:
            return
        }
    }
}

