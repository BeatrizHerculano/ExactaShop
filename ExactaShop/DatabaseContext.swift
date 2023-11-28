//
//  DatabaseContext.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 27/11/23.
//

import Foundation
import SwiftData
import Dependencies

struct DatabaseContext {
    static var appContext: ModelContext = {
        do {
            
            let container = try ModelContainer(for: Product.self, Size.self, CartProduct.self)
            return ModelContext(container)
        } catch {
            fatalError("Failed to create container.")
        }
    }()
    
    
    var context: () throws -> ModelContext
}

extension DatabaseContext: DependencyKey {
    public static let liveValue = Self(
        context: { DatabaseContext.appContext }
    )
}
