//
//  ViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/9/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GetUserData.shared.getUserData()
    }


}

