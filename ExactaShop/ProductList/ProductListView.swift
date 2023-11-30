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
    let store: StoreOf<ProductListFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.products) { viewStore in
                Group {
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
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            }
            .navigationTitle("Produtos")
            .toolbar(content: {
                NavigationLink  {
                    ShoppingCartView(store: Store(initialState: {
                        ShoppingCartFeature.State.init(products: [])
                    }(), reducer: {
                        ShoppingCartFeature()
                    }))
                } label: {
                    Text("Carrinho")
                }
                
            })
        }.onAppear{
            store.send(.viewLoaded)
        }
    }
}


