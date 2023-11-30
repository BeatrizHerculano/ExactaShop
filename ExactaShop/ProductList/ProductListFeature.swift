//
//  ListProductsFeature.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation
import ComposableArchitecture


@Reducer
struct ProductListFeature {
    @Dependency(\.networking) var networking
    @Dependency(\.cartDatabase) var database
    
    struct State: Equatable {
        var products: [Product]
    }
    enum Action: Equatable {
        case viewLoaded
        case setProducts([Product])
        case productTapped(Product)
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
                
            case .productTapped(let product):
                addProductToCart(product)
                return .none
            }
        }
    }
    
    func fetchProducts(_ send: Send<Action>) async {
        let result = await networking.getRequest(responseType: Products.self)
        switch result{
        case .success(let products):
            await send(.setProducts(products.products))
        case .failure(let error):
            print(error)
        }
    }
    
    func addProductToCart(_ product: Product){
        let existingCartProduct = database.fetch(style: product.style)
        
        if(existingCartProduct == nil){
            database.add(cartProduct: .init(product: product))
        }
    }
}
