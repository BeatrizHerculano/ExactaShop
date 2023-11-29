//
//  CartProductCellFeature.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 28/11/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CartProductCellFeature {
    @Dependency(\.cartDatabase) var database
    
    struct State: Equatable {
        var cartProduct: CartProduct = .init(
            product: .init(
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
        )
    }
    
    enum Action {
        case increaseButtonTapped(CartProduct)
        case decreaseButtonTapped(CartProduct)
        case changeQuantity(Int)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce{ state, action in
            switch action{
            case .increaseButtonTapped(let product):
                return .run { send in
                    await increaseQuantity(product,send)
                }
            case .decreaseButtonTapped(let product):
                if product.quantity > 1{
                    return .run { send in
                        await decreaseQuantity(product,send)
                    }
                }
                return .none
            case .changeQuantity(let quantity):
                state.cartProduct.quantity = quantity
                return .none
            
            }
        }
    }
    
    func removeProduct(){
        
    }
    
    func increaseQuantity(_ product: CartProduct,_ send: Send<Action>) async {
        product.quantity += 1
        database.update(cartProduct: product)
        await send(.changeQuantity(product.quantity))
    }
    
    func decreaseQuantity(_ product: CartProduct,_ send: Send<Action>) async {
        var quantity = product.quantity
        quantity -= 1
        database.update(cartProduct: product)
        await send(.changeQuantity(quantity))
    }
    
}
