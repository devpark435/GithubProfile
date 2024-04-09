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
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
            let url = "https://api.github.com/users/devpark435"
            
            AF.request(url).responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    User.shared.update(with: user)
                    completion(.success(user))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            }
        }
}
