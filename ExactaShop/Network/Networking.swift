//
//  Networking.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed
    case mockLoadingFailed
}

protocol NetworkProtocol{
    func getRequest<T: Decodable>(request: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class NetworkManager: NetworkProtocol {
    let apiURL = "http://www.mocky.io/v2/59b6a65a0f0000e90471257d"
    static let shared: NetworkManager = NetworkManager ()
    init() {}
    
    func getRequest<T: Decodable>(request: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: apiURL + request) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            print(error?.localizedDescription ?? "nao deu erro")
            
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                FileLoader.readJsonFromBundle(fileName: "MockDesafioIOS", responseType: responseType, completion: completion)
            }
        }
        
        task.resume()
    }
}
