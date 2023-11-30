//
//  ProductDetailsFeature.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 29/11/23.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ProductDetailsFeature {
    @Dependency(\.cartDatabase) var database
    
    struct State: Equatable {
        var product: Product = .init(
                name: "",
                style: "",
                codeColor: "",
                colorSlug: "",
                color: "",
                onSale: false,
                regularPrice: "",
                actualPrice: "",
                discountpercentage: "",
                installments: "",
                image: "",
                sizes: []
            )
    }
    
    enum Action {
        case addToCart(Product)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce{ state, action in
            switch action{
            
            case .addToCart(let product):
                addProductToCart(product)
                return .none
            }
        }
    }
    
    func addProductToCart(_ product: Product){
        let existingCartProduct = database.fetch(style: product.style)
        
        if(existingCartProduct == nil){
            database.add(cartProduct: .init(product: product))
        }
    }
    
}
