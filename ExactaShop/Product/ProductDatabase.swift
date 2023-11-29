//
//  ProductDatabase.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 27/11/23.
//

import Foundation
import SwiftData
import Dependencies

class ProductDatabase{
    
    @Dependency(\.databaseContext.context) var context
    let type = Product.self
    
    func add(product: Product){
        try? context().insert(product)
    }
    
    func remove(style: String){
        try? context().delete(
            model: Product.self,
            where:  #Predicate<Product>{ product in
                product.style == style
            }
        )
    }
    
    func removeAllData(){
        try? context().delete(model: Product.self)
    }
    
    func count() -> Int{
        guard let count = try? context().fetchCount(.init(
            predicate: #Predicate<Product>{ product in return true}
        )) else { return 0 }
        
        return count
    }
    
    func fetch(style: String) -> Product?{
        guard let object = try? context().fetch(.init(
            predicate: #Predicate<Product>{ product in product.style == style}
        )) else { return nil }
        
        return object.first
    }
    
    func fetchAll() -> [Product]{
        guard let objects = try? context().fetch(.init(
            predicate: #Predicate<Product>{ product in true }
        )) else { return [] }
        
        return objects
    }
}
