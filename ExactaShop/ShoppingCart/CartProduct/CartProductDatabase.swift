//
//  ShoppingCartDatabase.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 26/11/23.
//

import Foundation
import SwiftData
import Dependencies
class CartProductDatabase {
    
    @Dependency(\.databaseContext.context) var context
    let type = CartProduct.self

    func add(cartProduct: CartProduct) {
        try? context().insert(cartProduct)
    }
    
    func remove(style: String) {
        try? context().delete(
            model: CartProduct.self,
            where:  #Predicate<CartProduct>{ product in
                product.product.style == style
            }
        )
    }
    
    func removeAllData() {
        try? context().delete(model: CartProduct.self)
    }
    
    func count() -> Int {
        guard let count = try? context().fetchCount(.init(
            predicate: #Predicate<CartProduct>{ cartProduct in return true}
        )) else { return 0 }
        
        return count
    }
    
    func fetch(style: String) -> CartProduct? {
        guard let object = try? context().fetch(.init(
            predicate: #Predicate<CartProduct>{ product in product.product.style == style}
        )) else { return nil }
        
        return object.first
    }
    
    func fetchAll() -> [CartProduct] {
        guard let objects = try? context().fetch(.init(
            predicate: #Predicate<CartProduct>{ product in true }
        )) else { return [] }
        
        return objects
    }
    
    func update(cartProduct: CartProduct) {
        do{
            try context().save()
        } catch {
            print(error)
        }
        
    }
}
