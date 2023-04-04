//
//  NetworkManager.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol NetworkManagerProtocol: AnyObject {
    func fetch<T: Decodable>(dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)

}

final class NetworkManager: NetworkManagerProtocol {

    static var shared = NetworkManager()
    
    private let api = "http://afisha.api.kinopark.kz/api/schedule?date_from=&date_to=&dial_timeout=5s&request_timeout=5s&retries=0&page=1&per_page=1000"
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzcC5raW5vcGFyayIsInN1YiI6ImZyb250LnByb2QiLCJuYW1lIjoiYWZpc2hhLWFwaS5wcm9kIn0.IBScyJ7iIRrxh6nqLMCwHz1z4P0r0Epmsf6hA2abEjU"
    
        func fetch<T>(dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url = URL(string: api) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "OPTIONS"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("Asia/Almaty", forHTTPHeaderField: "TimeZone")
        request.addValue("ru-RU", forHTTPHeaderField: "Accept-Language")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        
        URLSession(configuration: config).dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}
