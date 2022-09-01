//
//  Product.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let productId: Int
    var name: String
    let stock, sellingPrice: Int
}
