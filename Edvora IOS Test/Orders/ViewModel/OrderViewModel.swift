//
//  OrderViewModel.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published private var users = [User]()
    @Published private(set) var products = [Product]()
    @Published private(set) var orders = [Order]()
    @Published private var dateConveter = DateConverter()
    @Published private(set) var error: NetworkManager.NetworkError?
    @Published var hasError = false
    @Published var isLoading = false
    @Published var searchOrder = ""
    @Published var items: Int = 0
    
    func getOrders() async {
        isLoading = true
           do {
               let ordersDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.orders, T: [Order].self)
               DispatchQueue.main.async {
                   defer { self.isLoading = false }
                   self.orders = ordersDecoded
                   self.items = self.orders.count
               }
           } catch {
               DispatchQueue.main.async {
                   self.hasError = true
                   if let networkError = error as? NetworkManager.NetworkError {
                       self.error = networkError
                   } else {
                       self.error = .customError(error: error)
                   }
               }
           }
    }
    var orderSerach: [Order] {
        if searchOrder.isEmpty {
            return orders
        } else {
            return orders.filter {
                $0.orderDate.localizedCaseInsensitiveContains(searchOrder)
            }
        }
    }
        
    func getUserName(_ orderId: Int) async -> String {
        isLoading = true
        do {
            //let usersDecoded = try FetchJSONFile.decode(file: FileName.UsersJSONFile, type: [User].self)
           let usersDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.users, T: [User].self)
            DispatchQueue.main.async {
                defer { self.isLoading = false }
                self.users = usersDecoded
                return
            }
           
            for user in self.users {
                if orderId == user.userId {
                   //print("user name Is: \(user.name)")
                    return user.name
                }
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    func getProductName(_ productId: Int) async -> String {
        isLoading = true
        do {
            //let productsDecoded = try FetchJSONFile.decode(file: FileName.ProductsJSONFile, type: [Product].self)
       let productsDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.products, T: [Product].self)
            DispatchQueue.main.async {
                defer { self.isLoading = false }
                self.products = productsDecoded
            }
            for product in self.products {
                if productId == product.productId {
                    //print("user name Is: \(product.name)")
                    return product.name
                }
            }
        } catch {
            print(error)
        }
        return ""
    }
}
