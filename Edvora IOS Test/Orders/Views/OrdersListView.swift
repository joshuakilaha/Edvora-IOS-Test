//
//  OrdersListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct OrdersListView: View {
    @StateObject var orderVM = OrderViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                if orderVM.isLoading {
                    ProgressView()
                } else {
                    orderList
                }
            }
            .navigationTitle("Orders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    totalItems
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            await orderVM.getOrders()
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
            ForEach(orderVM.orderSerach, id: \.orderDate) { order in
                NavigationLink {
                    OrderDetailView(order: order)
                } label: {
                    OrderListViewCell(order: order)
                }
            }
            .listRowBackground(Color.clear)
            .background(Theme.background)
        }
        .refreshable {
            Task {
                await orderVM.getOrders()
            }
        }
        .listStyle(SidebarListStyle())
        .searchable(text: $orderVM.searchOrder, prompt: "Search Order")
    }
    
    var totalItems: some View {
        Text("\(orderVM.items) Items")
            .bold()
            .opacity(orderVM.isLoading ? 0 : 1)
    }
}
