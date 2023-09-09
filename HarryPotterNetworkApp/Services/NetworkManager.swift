//
//  NetworkManager.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let link = "https://hp-api.onrender.com/api/characters"
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?,
                             complition: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            complition(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complition(.failure(.noData))
                print(error?.localizedDescription ?? "no description")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(type))
                }
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
//        guard let url = URL(string: url ?? "") else {
//            completion(.failure(.invalidUrl))
//            return
//        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
