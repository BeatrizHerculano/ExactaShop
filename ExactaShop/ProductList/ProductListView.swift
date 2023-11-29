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
                Group {
                    if(viewStore.isEmpty){
                        ProgressView()
                    } else{
                        ScrollView {
                            LazyVGrid(
                                columns: [
                                    GridItem(spacing: 2),
                                    GridItem(spacing: 2)
                                ],
                                spacing: 1
                            ){
                                ForEach(viewStore.state, id: \.style) { product in
                                    ZStack(alignment: .bottomTrailing) {
                                        ZStack(alignment: .topTrailing){
                                            NavigationLink {
                                                
                                                ProductDetailsView(
                                                    store: Store(
                                                        initialState: ProductDetailsFeature.State(product: product),
                                                        reducer: {
                                                            ProductDetailsFeature()
                                                        }))
                                            } label: {
                                                ProductCell(product: product)
                                            }

                                            if(product.onSale) {
                                                Image(systemName: "tag.fill")
                                                    .foregroundStyle(.green)
                                            }
                                        }
                                        
                                        Button {
                                            store.send(.productTapped(product))
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.blue)
                                                .clipShape(Circle())
                                                .frame(height: 40)
                                        }

                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            }
            .navigationTitle("Products")
            .toolbar(content: {
                NavigationLink  {
                    ShoppingCartView(store: Store(initialState: {
                        ShoppingCartFeature.State.init(products: [])
                    }(), reducer: {
                        ShoppingCartFeature()
                    }))
                } label: {
                    Text("carrinho")
                }
                
            })
        }.onAppear{
            store.send(.viewLoaded)
        }
    }
    
    func buildProduct(_ product: Product) -> Product{
        let testProduct: Product = .init(
            name: product.name,
            style: product.style,
            codeColor: product.codeColor,
            colorSlug: product.colorSlug,
            color: product.color,
            onSale: product.onSale,
            regularPrice: product.regularPrice,
            actualPrice: product.actualPrice,
            discountpercentage: product.discountpercentage,
            installments: product.installments,
            image: product.image,
            sizes: [])

        return testProduct
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
}
