//
//  ListProductsFeature.swift
//  ExactaShop
//
//  Created by Beatriz Herculano on 24/11/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ListProductsFeature {
  struct State: Equatable {
    var products: [Product]
  }
  enum Action {
    case viewLoaded
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      
      case .viewLoaded:
          print("view loaded")
          return .none
      }
    }
  }
}
