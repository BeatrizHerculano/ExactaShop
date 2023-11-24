//
//  Item.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation
import SwiftData

struct Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.style == rhs.style
    }
    
    var name: String
    var style: String
    var codeColor: String
    var colorSlug: String
    var color: String
    var onSale: Bool
    var regularPrice: String
    var actualPrice: String
    var discountpercentage: String
    var installments: String
    var image: String
    var sizes: [Size]
    
    init(name: String, style: String, codeColor: String, colorSlug: String, color: String, onSale: Bool, regularPrice: String, actualPrice: String, discountpercentage: String, installments: String, image: String, sizes: [Size]) {
        self.name = name
        self.style = style
        self.codeColor = codeColor
        self.colorSlug = colorSlug
        self.color = color
        self.onSale = onSale
        self.regularPrice = regularPrice
        self.actualPrice = actualPrice
        self.discountpercentage = discountpercentage
        self.installments = installments
        self.image = image
        self.sizes = sizes
    }
    
    func imageURL() -> URL?{
        guard let url = URL(string: image) else { return nil }
        return url
    }
    
    struct Size {
        var available: Bool
        var size: String
        var sku: String
    }
}
