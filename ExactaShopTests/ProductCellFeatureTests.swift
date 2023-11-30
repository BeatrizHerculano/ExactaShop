//
//  ProductCellFeatureTests.swift
//  ExactaShopTests
//
//  Created by Beatriz Herculano on 30/11/23.
//

import Foundation
import XCTest
import ComposableArchitecture
@testable import ExactaShop

@MainActor
final class CartProductCellFeatureTests: XCTestCase {
    
    
    
    func testActionIncreaseButtonWasTapped() async {
        let testId = UUID()
        let mockDatabase = CartDatabaseMocks()
        let cartProduct = CartProduct(
            product: .init(
                name: "",
                style: "",
                codeColor: "",
                colorSlug: "",
                color: "",
                onSale: false,
                regularPrice: "",
                actualPrice: "",
                discountpercentage: "",
                installments: "",
                image: "",
                sizes: []),
            quantity: 10)
        
        let sut = TestStore(initialState: CartProductCellFeature.State(id: testId)) {
            CartProductCellFeature()
        } withDependencies: {
            $0.cartDatabase = mockDatabase
        }
        
        
        
        await sut.send(.increaseButtonTapped(cartProduct))
        await sut.receive(\.changeQuantity)
        XCTAssertTrue(mockDatabase.updateWasCalled)
        
    }
    
    func testActionDecreaseButtonWasTapped() async {
        let testId = UUID()
        let mockDatabase = CartDatabaseMocks()
        let cartProduct = CartProduct(
            product: .init(
                name: "",
                style: "",
                codeColor: "",
                colorSlug: "",
                color: "",
                onSale: false,
                regularPrice: "",
                actualPrice: "",
                discountpercentage: "",
                installments: "",
                image: "",
                sizes: []),
            quantity: 10)
        
        let sut = TestStore(initialState: CartProductCellFeature.State(id: testId)) {
            CartProductCellFeature()
        } withDependencies: {
            $0.cartDatabase = mockDatabase
        }
        
        
        
        await sut.send(.decreaseButtonTapped(cartProduct))
        await sut.receive(\.changeQuantity)
        XCTAssertTrue(mockDatabase.updateWasCalled)
        
    }
}


