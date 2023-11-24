//
//  Item.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation
import SwiftData

@Model
final class Product {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
