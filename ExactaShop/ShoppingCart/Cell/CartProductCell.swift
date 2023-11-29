//
//  ShoppingCartCell.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 28/11/23.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct CartProductCell: View {

    let store: StoreOf<CartProductCellFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.cartProduct ) { viewStore in
            VStack{
                ProductCell(product: viewStore.product)
                HStack {
                    Button {
                        print("minus")
                        viewStore.send(.decreaseButtonTapped(viewStore.state))
                    } label: {
                        Label {
                            
                        } icon: {
                            Image(systemName: "minus")
                        }
                        
                    }
                    .labelStyle(.iconOnly)
                }
                .buttonBorderShape(.circle)
                
                Text("\(viewStore.quantity)")
                
                Button {
                    viewStore.send(.increaseButtonTapped(viewStore.state))
                } label: {
                    Image(systemName: "plus")
                }
                .labelStyle(.iconOnly)
            }
            .buttonBorderShape(.circle)
            
        }
    }
}
