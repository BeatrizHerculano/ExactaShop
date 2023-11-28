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
    @Dependency(\.databaseContext.context) var databaseContext

    func context() -> ModelContext{
        do{
            return try databaseContext()
        } catch {
            fatalError()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ProductListView(
                store: Store(initialState:ListProductsFeature.State(products: []),
                reducer: {
                ListProductsFeature()
            }))
        }
        .modelContext(context())
        
    }
}
