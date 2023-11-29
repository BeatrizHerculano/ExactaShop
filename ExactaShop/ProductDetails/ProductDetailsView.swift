//
//  ProductDetailsView.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 29/11/23.
//

import SwiftUI
import ComposableArchitecture

struct ProductDetailsView: View {
    var store: StoreOf<ProductDetailsFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.product ){ viewStore in
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    
                    AsyncImage(url: URL(string: viewStore.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            fatalError()
                        }
                    }
                    
                    
                    Text(viewStore.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    Text("Style: \(viewStore.style)")
                        .foregroundColor(.gray)
                    
                    Text("Color: \(viewStore.color)")
                        .foregroundColor(.gray)
                    
                    
                    if viewStore.onSale {
                        Text("On Sale! \(viewStore.discountpercentage)")
                            .foregroundStyle(.red)
                            .padding(.bottom, 8)
                        Text("\(viewStore.regularPrice)")
                            .bold()
                            .strikethrough()
                            .padding(.bottom, 8)
                    }
                    
                    
                    HStack {
                        Text("Price: ")
                            .foregroundColor(.gray)
                        Text(viewStore.actualPrice)
                            .foregroundStyle(.red)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    
                    Text("Installments: \(viewStore.installments)")
                        .foregroundStyle(.gray)
                        .padding(.bottom, 8)
                    
                    
                    Button {
                        viewStore.send(.addToCart(viewStore.state))
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .clipShape(Circle())
                            .frame(height: 40)
                    }
                    
                    
//                    Text("Available Sizes:")
//                        .font(.headline)
//                        .fontWeight(.bold)
                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 16) {
//                            ForEach(viewStore.sizes, id: \.sku) { size in
//                                
//                                Button {
//                                    print(size.size)
//                                } label: {
//                                    Text(size.size)
//                                        .foregroundStyle(size.available ? .green : .gray)
//                                        .padding(8)
//                                        .background(RoundedRectangle(cornerRadius: 8).stroke())
//                                }
//                                .disabled(!size.available)
//                                
//                                
//                            }
//                        }
//                        
//                    }
                }
                .padding()
            }
            .navigationTitle("Product Details")
        }
    }
    
}
