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
        case productsFetched([CartProduct])
        case removeProductButtonTapped(CartProduct)
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
