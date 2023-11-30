//
//  NetworkingManager.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 25/11/23.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed
}

public protocol NetworkProtocol{
    func getRequest<T: Decodable>(responseType: T.Type) async -> Result<T, NetworkError>
}

public class NetworkManager: NetworkProtocol {
    let apiURL = "http://www.mocky.io/v2/59b6a65a0f0000e90471257d"
    
    init() {}
    
    public func getRequest<T: Decodable>(responseType: T.Type) async -> Result<T, NetworkError> {
        
        guard let url = URL(string: apiURL) else {
            return .failure(.invalidURL)
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(responseType, from: data)
            return .success(decodedResponse)
            
        } catch {
            let result = await self.loadFromJson(responseType: responseType)
            return result
        }
    }
    
    private func loadFromJson<T: Decodable>(responseType: T.Type) async -> Result<T, NetworkError>{
        return await FileLoader.readJsonFromBundle(responseType: responseType)
    }
}
