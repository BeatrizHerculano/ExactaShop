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
    struct State {
        var products: [Product]
    }
    enum Action {
        case viewLoaded
        case setProducts([Product])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewLoaded:
                return .run { send in
                    
                }
            case .setProducts(let products):
                state.products = products
                return .none
            }
        }
    }
    
    func fetchShoppingCartProducts(_ send: Send<Action>) async {
        
    }
}
