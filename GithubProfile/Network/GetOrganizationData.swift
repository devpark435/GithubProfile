//
//  GetOrganizationData.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import Alamofire

class GetOrganizationData {
    static let shared = GetOrganizationData()
    
    // MARK: - Get Organization Data
    func getOrganizationData(completion: @escaping (Result<[OrganizationModel], Error>) -> Void) {
        let url = "https://api.github.com/users/devpark435/orgs"
        
        AF.request(url).responseDecodable(of: [OrganizationModel].self) { response in
            switch response.result {
            case .success(let organizations):
                completion(.success(organizations))
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
