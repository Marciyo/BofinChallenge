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

    /// Buy one apple, get second free
    private(set) var applePromotionEnabled = false

    /// Buy two oranges, get third free
    private(set) var oragnePromotionEnabled = false

    func addProduct(type: Product.ProductType) {
        let product = Product(type: type)
        products.append(product)
    }

    func prepareTotalString(from products: [Product]) -> String {
        let appleTotal = calculateTotal(for: .apple, from: products)
        let orangeTotal = calculateTotal(for: .orange, from: products)

        return "Total: \(appleTotal + orangeTotal)p"
    }

    private func calculateTotal(for type: Product.ProductType, from products: [Product]) -> Int {
        var promotionFilter: (Int) -> Bool = { _ in true }

        switch type {
        case .apple:
            if applePromotionEnabled {
                promotionFilter = { offset in
                   offset % 2 == 0
                }
            }
        case .orange:
            if oragnePromotionEnabled {
                promotionFilter = { offset in
                   offset % 3 != 2
                }
            }
        }

        let totalForProductType = products
            .filter { $0.type == type }
            .enumerated()
            .filter { promotionFilter($0.offset) }
            .map { $0.element.price }
            .reduce(0, +)

        return totalForProductType
    }

    func togglePromotion(for type: Product.ProductType) {
        switch type {
        case .apple:
            applePromotionEnabled.toggle()
        case .orange:
            oragnePromotionEnabled.toggle()
        }
    }
}
