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
    
    init(product: Product) {
        self.product = product
    }
}
