//
//  ProductViewModel.swift
//  Edvora IOS Test
//
//  Created by Mroot on 01/09/2022.
//

import Foundation

final class ProductViewModel: ObservableObject {
    @Published private(set) var products = [Product]()
    @Published private(set) var error: NetworkManager.NetworkError?
    @Published var hasError = false
    @Published var isLoading = false
    
    func getProducts() async {
     isLoading = true
        do {
            let productsDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.products, T: [Product].self)
            DispatchQueue.main.async {
                defer { self.isLoading = false }
                self.products = productsDecoded
            }
        } catch {
            hasError = true
            if let networkError = error as? NetworkManager.NetworkError {
                self.error = networkError
            } else {
                self.error = .customError(error: error)
            }
        }
    }
}
