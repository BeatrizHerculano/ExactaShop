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
                ScrollView{
                    LazyVGrid(columns: [GridItem(spacing: 0), GridItem(spacing: 0)], spacing: 0) {
                        ForEach(viewStore.state, id: \.style) { product in
                            ProductCell(product: product)
                        }
                    }
                }
                .padding()
                
            }
            .navigationTitle("Products")
        }.onAppear{
            store.send(.viewLoaded)
        }
    }
}

#Preview {
    ProductListView(store: Store(initialState:ListProductsFeature.State(products: [
        .init(
            name: "Produto Teste",
            style: "123456",
            codeColor: "123456_30",
            colorSlug: "Cor Teste",
            color: "Cinza",
            onSale: false,
            regularPrice: "R$ 199,99",
            actualPrice: "R$ 199,99",
            discountpercentage: "",
            installments:  "1x R$ 49,90",
            image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20001882_008_catalog_1.jpg?",
            sizes: [
                .init(available: true, size: "PP", sku: "4229_1000016_0_U")
            ]
        ),
        .init(
            name: "Produto Teste",
            style: "099877",
            codeColor: "099877_30",
            colorSlug: "Cor Teste",
            color: "Cinza",
            onSale: false,
            regularPrice: "R$ 199,99",
            actualPrice: "R$ 199,99",
            discountpercentage: "",
            installments:  "1x R$ 49,90",
            image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20001882_008_catalog_1.jpg?",
            sizes: [
                .init(available: true, size: "PP", sku: "4229_1000016_0_U")
            ]
        ),
        .init(
            name: "Produto Teste",
            style: "3878347",
            codeColor: "099877_30",
            colorSlug: "Cor Teste",
            color: "Cinza",
            onSale: false,
            regularPrice: "R$ 199,99",
            actualPrice: "R$ 199,99",
            discountpercentage: "",
            installments:  "1x R$ 49,90",
            image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20001882_008_catalog_1.jpg?",
            sizes: [
                .init(available: true, size: "PP", sku: "4229_1000016_0_U")
            ]
        )
    ]) , reducer: {
        ListProductsFeature()
    }))
        //.modelContainer(for: Product.self, inMemory: true)
}
