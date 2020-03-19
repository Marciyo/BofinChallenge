//
//  CheckoutViewModelTests.swift
//  BofinTests
//
//  Created by Marcel Mierzejewski on 19/03/2020.
//  Copyright © 2020 marcelmierzejewski. All rights reserved.
//

import XCTest
@testable import Bofin

class CheckoutViewModelTests: XCTestCase {
    private var viewModel: CheckoutViewModel!

    override func setUp() {
        viewModel = CheckoutViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testCalculatingTotal() {
        let apple = Product(type: .apple)
        XCTAssertEqual(apple.price, 60)

        let orange = Product(type: .orange)
        XCTAssertEqual(orange.price, 20)

        let totalString = viewModel.prepareTotalString(from: [apple, orange])

        XCTAssertEqual(totalString, "Total: 80p")
    }

    func testAddingProduct() {
        XCTAssertTrue(viewModel.products.isEmpty)

        viewModel.addProduct(type: .apple)

        XCTAssertEqual(viewModel.products.count, 1)
    }
}
