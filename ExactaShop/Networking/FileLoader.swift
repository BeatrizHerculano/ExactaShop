//
//  FileLoader.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 25/11/23.
//

import Foundation


class FileLoader{
    static func readJsonFromBundle<T: Decodable>(responseType: T.Type) async -> Result<T, NetworkError>{
        if let path = Bundle.main.path(forResource: "mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                    return .success(decodedResponse)
                } catch {
                    print("Error reading JSON file: \(error)")
                    return .failure(.noData)
                }
            } catch {
                print("Error reading JSON file: \(error)")
               return .failure(.noData)
            }
        }
        return .failure(.noData)
    }
}
