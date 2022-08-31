//
//  OrdersListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct OrdersListView: View {
    @State private var orders: [Order] = []

    var body: some View {
        List {
            ForEach(orders, id: \.orderDate) { order in
                Text("\(order.orderId)")
            }
        }
        .onAppear {
            do {
                let orderData = try FetchJSONFile.decode(file: FileName.OrdersJSONFile, type: [Order].self)
                print("Order Data \(orderData)")
                orders = orderData
            } catch {
                print(error)
            }
        }
    }
}

struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
    }
}
