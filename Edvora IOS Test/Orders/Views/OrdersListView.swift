//
//  OrdersListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct OrdersListView: View {
    @State private var orders: [Order] = []
    @StateObject var vm = OrderViewModel()
    var body: some View {
        NavigationView {
            orderList
                .navigationTitle("Orders")
        }
        .onAppear {
            do {
                let orderData = try FetchJSONFile.decode(file: FileName.OrdersJSONFile, type: [Order].self)
                print("Order Data \(orderData)")
                orders = orderData
            } catch {
                print(error)
            }
            let name = vm.getUserName(19)
            print(name)
        }
    }
}

struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
    }
}

extension OrdersListView {
    var orderList: some View {
        List {
            ForEach(orders, id: \.orderDate) { order in
               OrderListViewCell(order: order)
            }
            .listRowBackground(Color.clear)
            .background(Theme.background)
        }
        .listStyle(SidebarListStyle())
    }
}
