//
//  Product.swift
//  Bofin
//
//  Created by Marcel Mierzejewski on 19/03/2020.
//  Copyright © 2020 marcelmierzejewski. All rights reserved.
//

import Foundation

struct Product: Identifiable, Hashable {
    enum ProductType: String {
        case apple, orange
    }

    var id = UUID()

    let type: ProductType

    var name: String { type.rawValue.capitalized }
    var price: Int {
        switch type {
        case .apple:
            return 60
        case .orange:
            return 25
        }
    }
}
