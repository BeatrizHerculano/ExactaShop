//
//  ShoppingCartFeature.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 25/11/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ShoppingCartFeature {
    @Dependency(\.cartDatabase) var database
    
    struct State: Equatable {
        var products: [CartProduct]
        var totalPrice: String = "R$ 0,00"
    }
    enum Action {
        case viewLoaded
        case setProducts([CartProduct])
        case removeProductButtonTapped(CartProduct)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewLoaded:
                return .run { send in
                    await fetchShoppingCartProducts(send)
                }
            
            case .setProducts(let products):
                state.products = products
                return .none
            
            case .removeProductButtonTapped(let product):
                return .run { send in
                    await removeProduct(product, send)
                }
            }
            
        }
    }
    
    func fetchShoppingCartProducts(_ send: Send<Action>) async {
        let products = database.fetchAll()
        await send(.setProducts(products))
    }
    
    func removeProduct(_ product: CartProduct,_ send: Send<Action>) async {
        database.remove(style: product.product.style)
        await send(.viewLoaded)
    }
}
