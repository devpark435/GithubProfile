//
//  GetUserData.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/9/24.
//

import Foundation
import Alamofire

class GetUserData{
    static let shared = GetUserData()
    func getUserData(){
        let url = "https://api.github.com/users/devpark435"

        AF.request(url).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let value):
                print("Response: \(value)")
                // Update User.shared with the value from the response
                User.shared.update(with: value)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
