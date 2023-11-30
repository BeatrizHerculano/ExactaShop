//
//  NetworkMock.swift
//  ExactaShopTests
//
//  Created by Beatriz Herculano on 30/11/23.
//

import Foundation
import ExactaShop

final class NetworkMock: NetworkProtocol{
   var getRequestWasCalled: Bool = false
    
    func getRequest<T>(responseType: T.Type) async -> Result<T, ExactaShop.NetworkError> where T : Decodable {
        getRequestWasCalled = true
        return .failure(.requestFailed)
    }
    
    
}
