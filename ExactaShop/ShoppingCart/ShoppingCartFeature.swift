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
    @Dependency(\.uuid) var uuid
    
    struct State: Equatable {
        var totalPrice: String = "R$ 0,00"
        var cartItems: IdentifiedArrayOf<CartProductCellFeature.State> = []
    }
    enum Action {
        case viewLoaded
        case productsFetched([CartProduct])
        case removeProductButtonTapped(UUID)
        case cartItem(id: CartProductCellFeature.State.ID, action: CartProductCellFeature.Action)
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewLoaded:
                return .run { send in
                    await fetchShoppingCartProducts(send)
                }
            
            case .productsFetched (let products):
                state.totalPrice = calculateTotalPrice(products: products)
                state.cartItems = IdentifiedArrayOf(
                    uniqueElements: products.map {
                        CartProductCellFeature.State(
                            id: uuid(),
                            cartProduct: $0
                        )
                    }
                )
                return .none
            
            case .removeProductButtonTapped(let id):
                
                guard let index = state.cartItems.index(id: id) else { return .none}
                let item = state.cartItems[index].cartProduct
                
                return .run { send in
                    await removeProduct(item, send)
                }
                
            case .cartItem(id: _, action: let action):
                switch action {
                case .delegate(.quantityChanged):
                    return .send(.viewLoaded)
                case .delegate(.itemRemoved(let id)):
                    return .send(.removeProductButtonTapped(id))
                default:
                    return .none
                }
            }
            
        }.forEach(
            \.cartItems,
             action: /ShoppingCartFeature.Action.cartItem(id:action:)
        ) {
            CartProductCellFeature()
        }
    }
    
    func fetchShoppingCartProducts(_ send: Send<Action>) async {
        let products = database.fetchAll()
        await send(.productsFetched(products))
    }
    
    func removeProduct(_ product: CartProduct,_ send: Send<Action>) async {
        database.remove(style: product.product.style)
        await send(.viewLoaded)
    }
    
    func calculateTotalPrice(products: [CartProduct]) -> String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        let total = products.reduce(Decimal(0)) { acc, current in
            let treatedRegularPrice = current.product.regularPrice.replacingOccurrences(of: " ", with: "")
            let number = formatter.number(from: treatedRegularPrice)
            let decimalValue = number?.decimalValue ?? 0
            let decimalQuantity = Decimal(current.quantity)
            
            return acc + (decimalValue *  decimalQuantity)
        }
        
        if let formattedString = formatter.string(from: NSDecimalNumber(decimal: total)) {
               return formattedString
        } else {
               return "Invalid Currency Value"
        }
    }
}
