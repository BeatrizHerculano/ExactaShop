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
                    VStack(alignment:.leading) {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(spacing: 3), GridItem(spacing: 3)], spacing: 1) {
                                ForEachStore(
                                    self.store.scope(
                                        state: \.cartItems,
                                        action: ShoppingCartFeature.Action
                                            .cartItem(id: action:)
                                    )
                                ) { productStore in
                                    CartProductCell(store: productStore)
                                        
                                }
                            }
                        }
                        .frame(width: geometry.size.width)
                        
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
