//
//  Order.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

struct Order: Codable {
    let orderId, productId, quantity, userId: Int
    let orderDate: String
}
