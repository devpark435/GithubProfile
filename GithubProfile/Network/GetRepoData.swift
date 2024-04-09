//
//  GetRepoData.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import Alamofire

class GetRepoData{
    static let shared = GetRepoData()
    func getRepoData(completion: @escaping (Result<[Repository], Error>) -> Void) {
            let url = "https://api.github.com/users/devpark435/repos"
            
            AF.request(url).responseDecodable(of: [Repository].self) { response in
                switch response.result {
                case .success(let repository):
                    completion(.success(repository))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            }
        }
}
