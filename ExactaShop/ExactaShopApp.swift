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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ProductListView(
                store: Store(initialState:ListProductsFeature.State(products: []),
                reducer: {
                ListProductsFeature()
            }))
        }
        .modelContainer(sharedModelContainer)
    }
}
