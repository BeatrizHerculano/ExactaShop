//
//  CartProdutct.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 25/11/23.
//

import Foundation
import SwiftData

@Model
class CartProduct{
    
    var id: UUID { return uuidKey }
        
    @Attribute(.unique) var uuidKey: UUID = UUID()
    
    var product: Product
    var quantity: Int
    
    init(product: Product, quantity: Int = 1) {
        self.product = product
        self.quantity = quantity
    }
}
