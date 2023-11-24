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
            AsyncImage(url: product.imageURL()) { image in
                image.resizable()
                    .scaledToFit()
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            
            Text(product.name)
                .padding(.top, 8)
            
            Text(product.regularPrice)
                .padding(.top, 8)
                .padding(.bottom, 30)

        }
        .background(Color.white)
        .border(.gray, width: 1)
        
        
        
        
    }
}

#Preview {
    ProductCell(product:
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
            )
    )
    .previewLayout(.sizeThatFits)
    //.modelContainer(for: Product.self, inMemory: true)
}

