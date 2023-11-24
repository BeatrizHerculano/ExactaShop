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
                store: Store(initialState:ListProductsFeature.State(products: [
                
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
                    )
                
                ]),
                reducer: {
                ListProductsFeature()
            }))
        }
    }
}
