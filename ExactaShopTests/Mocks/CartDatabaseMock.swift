//
//  CartDatabaseMock.swift
//  ExactaShopTests
//
//  Created by Beatriz Herculano on 30/11/23.
//

import Foundation
import ExactaShop

class CartDatabaseMocks: CartProductDatabaseProtocol{
    var addWasCalled: Bool = false
    var removeWasCalled: Bool = false
    var removeAllWasCalled: Bool = false
    var countWasCalled: Bool = false
    var fetchWasCalled: Bool = false
    var fetchAllWasCalled: Bool = false
    var updateWasCalled: Bool = false
    
    func add(cartProduct: ExactaShop.CartProduct) {
        addWasCalled = true
    }
    
    func remove(style: String) {
        removeWasCalled = true
    }
    
    func removeAllData() {
        removeAllWasCalled = true
    }
    
    func count() -> Int {
        countWasCalled = true
        return 0
    }
    
    func fetch(style: String) -> ExactaShop.CartProduct? {
        fetchWasCalled = true
        return nil
    }
    
    func fetchAll() -> [ExactaShop.CartProduct] {
        fetchAllWasCalled = true
        return []
    }
    
    func update(cartProduct: ExactaShop.CartProduct) {
        updateWasCalled = true
    }
    
    
}
