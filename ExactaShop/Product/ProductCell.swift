//
//  ContentView.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct ProductCell: View {
    var product: Product
    
    var body: some View {
        
        VStack{
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .foregroundColor(.gray)
                @unknown default:
                    fatalError()
                }
            }
            Text(product.name)
                .padding(.top, 8)
            
            Text(product.regularPrice)
                .padding(.top, 8)
                .padding(.bottom, 30)
            
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
    }
}

