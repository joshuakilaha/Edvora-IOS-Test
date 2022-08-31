//
//  OrderViewModel.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published private var users: [User] = []
    @Published private var products: [Product] = []
    
    func getUserName(_ orderId: Int) -> String {
        do {
            let userData = try FetchJSONFile.decode(file: FileName.UsersJSONFile, type: [User].self)
            self.users = userData
            for user in self.users {
                if orderId == user.userId {
                    print("user name Is: \(user.name)")
                    return user.name
                }
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    
    func getProductName(_ productId: Int) -> String {
        do {
            let productData = try FetchJSONFile.decode(file: FileName.ProductsJSONFile, type: [Product].self)
            self.products = productData
            for product in self.products {
                if productId == product.productId {
                    print("user name Is: \(product.name)")
                    return product.name
                }
            }
        } catch {
            print(error)
        }
        return ""
    }
}
