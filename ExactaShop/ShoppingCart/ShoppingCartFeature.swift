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
    
    struct State {
        var products: [CartProduct]
    }
    enum Action {
        case viewLoaded
        case setProducts([CartProduct])
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
            }
        }
    }
    
    func fetchShoppingCartProducts(_ send: Send<Action>) async {
//        database.removeAllData()
        let products = database.fetchAll()
        await send(.setProducts(products))
    }
}
