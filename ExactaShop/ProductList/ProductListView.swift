//
//  ContentView.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct ProductListView: View {
    let store: StoreOf<ListProductsFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.products) { viewStore in
                List {
                    ForEach(viewStore.state) { product in
                        Text(product.name)
                    }
                }
                .navigationTitle("Products")
            }
        }
    }
}

#Preview {
    ProductListView(store: Store(initialState:ListProductsFeature.State(products: [
        .init(name: "testen 1"),
        .init(name: "testen 2"),
        .init(name: "testen 3")
    ]) , reducer: {
        ListProductsFeature()
    }))
        .modelContainer(for: Product.self, inMemory: true)
}
