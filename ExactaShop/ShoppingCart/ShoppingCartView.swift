//
//  ShoppingCartView.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 25/11/23.
//

import Foundation
import SwiftUI
import SwiftData
import ComposableArchitecture


struct ShoppingCartView: View {
    let store: StoreOf<ShoppingCartFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GeometryReader { geometry in
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(spacing: 2), GridItem(spacing: 2)], spacing: 1) {
                                ForEach(viewStore.state.products, id: \.id) { product in
                                    
                                    ZStack(alignment: .topTrailing) {
                                        CartProductCell(store: Store(initialState: CartProductCellFeature.State(cartProduct: product), reducer: {
                                            CartProductCellFeature()
                                        }))
                                        
                                        Button(action: {
                                            viewStore.send(.removeProductButtonTapped(product))
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.red)
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("Valor total")
                                .foregroundColor(.white)
                                .bold()
                            Text(viewStore.state.totalPrice)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(width: geometry.size.width, alignment: .bottomLeading)
                        .padding()
                        .background(Color.red)
                        
                        Spacer()
                    }
                    .frame(height: geometry.size.height)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                }
            }
            .navigationTitle("Carrinho")
            
        }.onAppear{
            store.send(.viewLoaded)
        }
    }
    
}
