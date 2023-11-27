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
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.products) { viewStore in
                Group {
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(spacing: 2), GridItem(spacing: 2)], spacing: 1) {
                            
                            ForEach(viewStore.state, id: \.id) { product in
                                Text("produto")
//                                ProductCell(product: product.product)
                                
                            }
                        }
                    }
                    .padding()
                }
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            }
            .navigationTitle("Products")
        }.onAppear{
            store.send(.viewLoaded)
        }
    }
    
}
