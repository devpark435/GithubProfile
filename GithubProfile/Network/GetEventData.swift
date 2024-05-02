//
//  GetEventData.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import Alamofire

class GetEventData{
    static let shared = GetEventData()
    
    // MARK: - Get Event Data
    func getEventData(completion: @escaping (Result<[EventModel], Error>) -> Void) {
        let url = "https://api.github.com/users/devpark435/events"
        
        AF.request(url).responseDecodable(of: [EventModel].self) { response in
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
