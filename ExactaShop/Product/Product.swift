//
//  Item.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation
import SwiftData

struct Products: Decodable {
    var products: [Product]
}

@Model
public class Product: Equatable, Decodable {
    
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
    @Relationship(deleteRule: .nullify, inverse: \Size.product) var sizes: [Size]

    
    enum ProductCodingKeys: String, CodingKey {
        case name
        case style
        case codeColor = "code_color"
        case colorSlug = "color_slug"
        case color
        case onSale = "on_sale"
        case regularPrice = "regular_price"
        case actualPrice = "actual_price"
        case discountpercentage = "discount_percentage"
        case installments
        case image
        case sizes
    }
    
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.style == rhs.style
    }
    
    
    init(name: String, style: String, codeColor: String, colorSlug: String, color: String, onSale: Bool, regularPrice: String, actualPrice: String, discountpercentage: String, installments: String, image: String, sizes: [Size], cartProduct: CartProduct? = nil) {
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
    
    public required init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: ProductCodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.style = try container.decode(String.self, forKey: .style)
            self.codeColor = try container.decode(String.self, forKey: .codeColor)
            self.colorSlug = try container.decode(String.self, forKey: .colorSlug)
            self.color = try container.decode(String.self, forKey: .color)
            self.onSale = try container.decode(Bool.self, forKey: .onSale)
            self.regularPrice = try container.decode(String.self, forKey: .regularPrice)
            self.actualPrice = try container.decode(String.self, forKey: .actualPrice)
            self.discountpercentage = try container.decode(String.self, forKey: .discountpercentage)
            self.installments = try container.decode(String.self, forKey: .installments)
            self.image = try container.decode(String.self, forKey: .image)
//            self.sizes = try container.decode([Size].self, forKey: .sizes)
            self.sizes = []
        } catch {
            throw error
        }
        
    }
    
    func imageURL() -> URL?{
        guard let url = URL(string: image) else { return nil }
        return url
    }
    
}

@Model
class Size: Decodable {
    var available: Bool
    var size: String
    @Attribute(.unique) var sku: String
    var product: Product?
    
    init(available: Bool, size: String, sku: String) {
        self.available = available
        self.size = size
        self.sku = sku
    }
    
    enum SizeCodingKeys: CodingKey{
        case available
        case size
        case sku
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: SizeCodingKeys.self)
            self.available = try container.decode(Bool.self, forKey: .available)
            self.size = try container.decode(String.self, forKey: .size)
            self.sku = try container.decode(String.self, forKey: .sku)
        } catch {
            throw error
        }
    }
}
