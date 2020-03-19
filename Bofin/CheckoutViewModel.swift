//
//  CheckoutViewModel.swift
//  Bofin
//
//  Created by Marcel Mierzejewski on 19/03/2020.
//  Copyright © 2020 marcelmierzejewski. All rights reserved.
//

import Foundation
import Combine

final class CheckoutViewModel {
    @Published var products: [Product] = []
    
    func addProduct(type: Product.ProductType) {
        let product = Product(type: type)
        products.append(product)

        print("Added \(product). Current count: \(products.count)")
    }
}
