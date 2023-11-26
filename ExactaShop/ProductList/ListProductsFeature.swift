//
//  ListProductsFeature.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ListProductsFeature {
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
                    await fetchProducts(send)
                }
                
            case .setProducts(let products):
                state.products = products
                return .none
            }
        }
    }
    
    func fetchProducts(_ send: Send<Action>) async {
        let result = await NetworkManager.shared.getRequest(responseType: Products.self)
        switch result{
        case .success(let products):
            await send(.setProducts(products.products))
        case .failure(let error):
            print(error)
        }
    }
}
