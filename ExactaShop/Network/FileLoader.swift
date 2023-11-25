//
//  FileLoader.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 25/11/23.
//

import Foundation


class FileLoader {
    static func readJsonFromBundle<T: Decodable>(fileName: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>)-> Void) {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            completion(.failure(.mockLoadingFailed))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
                return
            } catch {
                print("Error reading JSON file: \(error)")
                completion(.failure(.mockLoadingFailed))
                return
            }
        } catch {
            print("Error reading JSON file: \(error)")
            completion(.failure(.mockLoadingFailed))
            return
        }
        
    }
}
