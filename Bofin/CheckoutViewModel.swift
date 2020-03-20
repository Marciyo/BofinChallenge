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
    private var applePromotionEnabled = false

    /// Buy two oranges, get third free
    private var oragnePromotionEnabled = false

    func addProduct(type: Product.ProductType) {
        let product = Product(type: type)
        products.append(product)

        print("Added \(product). Current count: \(products.count)")
    }

    func prepareTotalString(from products: [Product]) -> String {
        var totalPrice: Int = 0

        let apples = products.filter { $0.type == .apple }
        let oranges = products.filter { $0.type == .orange }

        if applePromotionEnabled {
            let everySecondFreeTotal = apples
                .enumerated()
                .filter { $0.offset % 2 == 0 }
                .map { $0.element.price }
                .reduce(0, +)

            totalPrice = totalPrice + everySecondFreeTotal
        } else {
            totalPrice = totalPrice + apples.map { $0.price }.reduce(0, +)
        }

        if oragnePromotionEnabled {
            let everyThirdFreeTotal = oranges
                .enumerated()
                .filter { $0.offset % 3 != 2 }
                .map { $0.element.price }
                .reduce(0, +)

            totalPrice = totalPrice + everyThirdFreeTotal
        } else {
            totalPrice = totalPrice + oranges.map { $0.price }.reduce(0, +)
        }

        return "Total: \(totalPrice)p"
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
