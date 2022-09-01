//
//  Order.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

// MARK: Order
struct Order: Codable {
    var orderId, productId, quantity, userId: Int
    var orderDate: String
}
