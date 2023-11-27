//
//  ExactaShopApp.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct ExactaShopApp: App {
    
    var body: some Scene {
        WindowGroup {
            ProductListView(
                store: Store(initialState:ListProductsFeature.State(products: []),
                reducer: {
                ListProductsFeature()
            }))
        }
        .modelContainer(
            for: [Product.self, Size.self, CartProduct.self]
        )
    }
}
