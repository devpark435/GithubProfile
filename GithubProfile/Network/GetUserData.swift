//
//  GetUserData.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/9/24.
//

import Alamofire

class GetUserData{
    static let shared = GetUserData()
    
    // MARK: - Get User Data
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        let url = "https://api.github.com/users/devpark435"
        
        AF.request(url).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let user):
                User.shared.update(with: user)
                completion(.success(user))
            case .failure(let error):
                print("Get User Data Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Get Readme.md
    func getUserMd(completion: @escaping (Result<ReadmeResponse, Error>) -> Void) {
        let url = "https://api.github.com/repos/devpark435/devpark435/readme"
        
        AF.request(url).responseDecodable(of: ReadmeResponse.self) { response in
            switch response.result {
            case .success(let readmeResponse):
                completion(.success(readmeResponse))
            case .failure(let error):
                print("Get User READ.md Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
