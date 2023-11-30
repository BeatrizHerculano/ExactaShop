//
//  NetworkingDependencies.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 26/11/23.
//

import Foundation
import Dependencies
private enum NetworkingKey: DependencyKey {
    static let liveValue: any NetworkProtocol = NetworkManager()
}

extension DependencyValues {
  var networking: NetworkProtocol {
    get { self[NetworkingKey.self] }
    set { self[NetworkingKey.self] = newValue }
  }
}
