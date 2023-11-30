//
//  DatabaseDependencies.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 26/11/23.
//

import Dependencies

extension DependencyValues {
  var databaseContext: DatabaseContext {
    get { self[DatabaseContext.self] }
    set { self[DatabaseContext.self] = newValue }
  }
}


private enum ShoppingCartDatabaseKey: DependencyKey {
    static let liveValue: any CartProductDatabaseProtocol = CartProductDatabase()
}

extension DependencyValues {
  var cartDatabase: CartProductDatabaseProtocol {
    get { self[ShoppingCartDatabaseKey.self] }
    set { self[ShoppingCartDatabaseKey.self] = newValue }
  }
}


private enum ProductDatabaseKey: DependencyKey {
    static let liveValue: any ProductDatabaseProtocol = ProductDatabase()
}

extension DependencyValues {
  var productDatabase: ProductDatabaseProtocol {
    get { self[ProductDatabaseKey.self] }
    set { self[ProductDatabaseKey.self] = newValue }
  }
}
