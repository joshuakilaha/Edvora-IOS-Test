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
//            let usersDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.users, T: [User].self)
            let usersDecoded = try FetchJSONFile.decode(file: FileName.UsersJSONFile, type: [User].self)
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
            //let productsDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.products, T: [Product].self)
            let productsDecoded = try FetchJSONFile.decode(file: FileName.ProductsJSONFile, type: [Product].self)
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
    
    
    func TotalQuantityPerMonth() {
        do {
            let orderData = try FetchJSONFile.decode(file: FileName.OrdersJSONFile, type: [Order].self)
            self.orders = orderData
            
        } catch {
            print(error)
        }
    }
}

extension OrderViewModel {
    enum OrderMonth: String {
        case Jan
        case Feb
        case Mar
        case Apr
        case May
        case Jun
        case Jul
        case Aug
        case Sep
        case Oct
        case Nov
        case Dec
    }
}

/*
extension OrderViewModel.OrderMonth {
    var monthQuantity: String? {
        switch self {

        case .Jan:
            return "January"
        case .Feb:
            return "February"
        case .Mar:
            return "March"
        case .Apr:
            return "April"
        case .May:
            return "May"
        case .Jun:
            return "June"
        case .Jul:
            return "July"
        case .Aug:
            return "August"
        case .Sep:
            return "September"
        case .Oct:
            return "October"
        case .Nov:
            return "November"
        case .Dec:
            return "December"
        }
    }
}
 */

/*
 private extension NetworkManager {
     func buildRequest(from url: URL, methodType: MethodType) -> URLRequest {
         var request = URLRequest(url: url)
         
         switch methodType {
         case .GET:
             request.httpMethod = "GET"
         case .POST(let data):
             request.httpMethod = "POST"
             request.httpBody = data
         }
         return request
     }
 }
 */

private extension OrderViewModel {

    func monthQunatity(orderMonth: OrderMonth) -> OrderMonth {
        
        switch orderMonth {
        case .Jan:
            return .Jan
        case .Feb:
            return .Feb
        case .Mar:
            return .Mar
        case .Apr:
            return .Apr
        case .May:
            return .May
        case .Jun:
            return .Jun
        case .Jul:
            return .Jul
        case .Aug:
            return .Aug
        case .Sep:
            return .Sep
        case .Oct:
            return .Oct
        case .Nov:
            return .Nov
        case .Dec:
            return .Dec
        }
    }
}



extension OrderViewModel {
    func quntityPerMonth(month: String, quantity: Int) {
        
        //var value = 0
        if month == "Jan" {
            for value in month {
                print("Total Values = \(value)")
            }
        }
    }
}


/*
 

 private extension OrderViewModel.orderMonth {
     func monthQunatity(month: String) -> String {
         switch self {

         case .January:
             return "January"
         case .February:
             return "February"
         case .March:
             return "March"
         case .April:
             return "April"
         case .May:
             return "May"
         case .June:
             return "June"
         case .July:
             return "July"
         case .August:
             return "August"
         case .September:
             return "September"
         case .October:
             return "October"
         case .November:
             return "November"
         case .December:
             return "December"
         }
     }
 }
 */
