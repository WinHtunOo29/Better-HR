//
//  NetworkManager.swift
//  Better HR
//
//  Created by Win Htun Oo on 21/03/2024.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidResponse
    case requestFailed
    case decodingError
}

struct NetworkingManager {
    static let shared = NetworkingManager()
    
    private let baseURL = "https://api.themoviedb.org/3"
    
    private init() {}
    
    func request<T: Decodable>(endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let url = baseURL + endpoint
        
        let headers: HTTPHeaders = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjY4MzI4ZjI0ZDg1MGUyZWJkY2U5MzczY2VkNDlmYSIsInN1YiI6IjY1ZmJlMDEyMDQ3MzNmMDE3ZGU3ZTUyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VpDikhLtG1gn3-4WZ9fomLJIWya6GPvb-TwwN5F2ldw"
        ]
        
        AF.request(url, method: method, parameters: parameters, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
}
